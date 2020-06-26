package main

import data.utils.labels
import data.utils.openshift

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  not input.spec.replicas

  msg := sprintf("%s/%s: replicas is null.", [input.kind, input.metadata.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  input.spec.replicas <= 1

  msg := sprintf("%s/%s: replicas is %d - expected replicas to be greater than 1 for HA guarantees.", [input.kind, input.metadata.name, input.spec.replicas])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  input.spec.replicas % 2 == 0

  msg := sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [input.kind, input.metadata.name, input.spec.replicas])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not container.readinessProbe

  msg := sprintf("%s/%s: container '%s' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html", [input.kind, input.metadata.name, container.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not container.livenessProbe

  msg := sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html", [input.kind, input.metadata.name, container.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  container.livenessProbe
  container.readinessProbe
  container.livenessProbe == container.readinessProbe

  msg := sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [input.kind, input.metadata.name, container.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]

  # "Factor out" isLimitsOrRequestsSet to do an OR
  not isLimitsOrRequestsSet with input as container

  msg := sprintf("%s/%s: container '%s' has no limits/request for its resources. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers", [input.kind, input.metadata.name, container.name])
}

isLimitsOrRequestsSet {
  input.resources.limits
}

isLimitsOrRequestsSet {
  input.resources.requests
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not container.resources.limits.memory

  msg := sprintf("%s/%s: container '%s' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers", [input.kind, input.metadata.name, container.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]

  not startswith(container.resources.requests.memory, "$")
  not startswith(container.resources.limits.memory, "$")
  not isResourceMemoryUnitsValid with input as container

  msg := sprintf("%s/%s: container '%s' memory resources for limits or requests (%s / %s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [input.kind, input.metadata.name, container.name, container.resources.limits.memory, container.resources.requests.memory])
}

isResourceMemoryUnitsValid {
  memoryLimitsUnit := regex.find_n("[A-Za-z]+", input.resources.limits.memory, 1)[0]
  memoryRequestsUnit := regex.find_n("[A-Za-z]+", input.resources.requests.memory, 1)[0]

  units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
  memoryLimitsUnit == units[_]
  memoryRequestsUnit == units[_]
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]

  not isResourceCpuRequestsUnitsValid with input as container

  msg := sprintf("%s/%s container '%s' cpu resources for requests (%s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [input.kind, input.metadata.name, container.name, container.resources.requests.cpu])
}

isResourceCpuRequestsAnCore {
  is_number(input.resources.requests.cpu)
  to_number(input.resources.requests.cpu)
}

isResourceCpuRequestsUnitsValid {
  isResourceCpuRequestsAnCore
}

isResourceCpuRequestsUnitsValid {
  not isResourceCpuRequestsAnCore

  # 'cpu' can be a quoted number, which is why we concat an empty string[] to match whole cpu cores
  cpuLimitsUnit := array.concat(regex.find_n("[A-Za-z]+", input.resources.requests.cpu, 1), [""])[0]

  units := ["m", ""]
  cpuLimitsUnit == units[_]
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]

  not startswith(container.resources.requests.memory, "$")
  not startswith(container.resources.limits.memory, "$")

  isResourceMemoryInverted with input as container

  msg := sprintf("%s/%s: container '%s' memory resources for limits/requests (%s / %s) are inverted. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [input.kind, input.metadata.name, container.name, container.resources.limits.memory, container.resources.requests.memory])
}

isResourceMemoryInverted {
  request := units.parse_bytes(input.resources.requests.memory)
  limit := units.parse_bytes(input.resources.limits.memory)

  request > limit
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  container.resources.limits.cpu

  msg := sprintf("%s/%s: container '%s' has cpu limits (%d). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits", [input.kind, input.metadata.name, container.name, container.resources.limits.cpu])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  endswith(container.image, ":latest")

  msg := sprintf("%s/%s: container '%s' is using the latest tag for its image (%s), which is an anti-pattern.", [input.kind, input.metadata.name, container.name, container.image])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  input.spec.template.spec.hostNetwork

  msg := sprintf("%s/%s: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.", [input.kind, input.metadata.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  volume := input.spec.template.spec.volumes[_]
  not containersVolumeMountsContainsVolume(input.spec.template.spec.containers, volume)

  msg := sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [input.kind, input.metadata.name, volume.name])
}

containersVolumeMountsContainsVolume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  volumeMount := container.volumeMounts[_]
  not volumesContainsVolumeMount(input.spec.template.spec.volumes, volumeMount)

  msg := sprintf("%s/%s: container '%s' has a volumeMount '%s' which does not have a mapped volume.", [input.kind, input.metadata.name, container.name, volumeMount.name])
}

volumesContainsVolumeMount(volumes, volumeMount) {
  volumes[_].name == volumeMount.name
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  volumeMount := container.volumeMounts[_]
  not startswith(volumeMount.mountPath, "/var/run")

  msg := sprintf("%s/%s: container '%s' has a volumeMount '%s' mountPath at '%s'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret", [input.kind, input.metadata.name, container.name, volumeMount.name, volumeMount.mountPath])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  env := container.env[_]
  env.valueFrom.secretKeyRef

  msg := sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars.", [input.kind, input.metadata.name, container.name, env.valueFrom.secretKeyRef.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  env := container.env[_]
  env.valueFrom.secretKeyRef

  msg := sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars.", [input.kind, input.metadata.name, container.name, env.valueFrom.secretKeyRef.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  labels.isCommonK8sLabelNotSet with input as input.spec.template.metadata

  msg := sprintf("%s/%s: does not contain all the expected k8s labels in 'spec.template.metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [input.kind, input.metadata.name])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not isEnvMaxMemorySet with input as container

  msg := sprintf("%s/%s: container '%s' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options", [input.kind, input.metadata.name, container.name])
}

isEnvMaxMemorySet {
  env := input.env[_]
  env.name == "CONTAINER_MAX_MEMORY"
  env.valueFrom.resourceFieldRef.resource == "limits.memory"
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  some key
  value := input.metadata.labels[key]

  not labelKeyStartsWithExpected(key)

  msg := sprintf("%s/%s: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com'. Found '%s'", [input.kind, input.metadata.name, key])
}

labelKeyStartsWithExpected(key) {
  startswith(key, "app.kubernetes.io/")
}

labelKeyStartsWithExpected(key) {
  startswith(key, "redhat-cop.github.com/")
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not is_array(container.command)

  msg := sprintf("%s/%s: container '%s' command '%s' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container", [input.kind, input.metadata.name, container.name, container.command])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  not is_array(container.args)

  msg := sprintf("%s/%s: container '%s' args '%s' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container", [input.kind, input.metadata.name, container.name, container.args])
}

warn[msg] {
  openshift.isDeploymentOrDeploymentConfig

  container := input.spec.template.spec.containers[_]
  containerOptsContainsXmx with input as container

  msg := sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [input.kind, input.metadata.name, container.name])
}

containerOptsContainsXmx {
  value := input.command[_]
  contains(value, "-Xmx")
}

containerOptsContainsXmx {
  value := input.args[_]
  contains(value, "-Xmx")
}

containerOptsContainsXmx {
  value := input.env[_]
  contains(value.value, "-Xmx")
}

warn[msg] {
  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy

  openshift.isDeploymentOrDeploymentConfig

  kb := 1024
  mb := kb * 1024
  gb := mb * 1024
  upperBound := 6 * gb

  container := input.spec.template.spec.containers[_]

  not startswith(container.resources.limits.memory, "$")
  memoryInBytes := units.parse_bytes(container.resources.limits.memory)
  memoryInBytes > upperBound

  msg := sprintf("%s/%s: container '%s' has a memory limit of '%s' which is larger than the upper '%dGi' limit.", [input.kind, input.metadata.name, container.name, container.resources.limits.memory, (upperBound / gb)])
}

warn[msg] {
  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy

  openshift.isDeploymentOrDeploymentConfig

  kb := 1024
  mb := kb * 1024
  gb := mb * 1024
  upperBound := 2 * gb

  container := input.spec.template.spec.containers[_]

  not startswith(container.resources.requests.memory, "$")
  memoryInBytes := units.parse_bytes(container.resources.requests.memory)
  memoryInBytes > upperBound

  msg := sprintf("%s/%s: container '%s' has a memory request of '%s' which is larger than the upper '%dGi' limit.", [input.kind, input.metadata.name, container.name, container.resources.requests.memory, (upperBound / gb)])
}