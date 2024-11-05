# Policies

## Violations

* [RHCOP-COMBINE-00001: Namespace has a NetworkPolicy](#rhcop-combine-00001-namespace-has-a-networkpolicy)
* [RHCOP-COMBINE-00002: Namespace has a ResourceQuota](#rhcop-combine-00002-namespace-has-a-resourcequota)
* [RHCOP-OCP_BESTPRACT-00001: Common k8s labels are set](#rhcop-ocp_bestpract-00001-common-k8s-labels-are-set)
* [RHCOP-OCP_BESTPRACT-00002: Container env has CONTAINER_MAX_MEMORY set](#rhcop-ocp_bestpract-00002-container-env-has-container_max_memory-set)
* [RHCOP-OCP_BESTPRACT-00003: Container image is not set as latest](#rhcop-ocp_bestpract-00003-container-image-is-not-set-as-latest)
* [RHCOP-OCP_BESTPRACT-00004: Container image is not from a known registry](#rhcop-ocp_bestpract-00004-container-image-is-not-from-a-known-registry)
* [RHCOP-OCP_BESTPRACT-00005: Container does not set Java Xmx option](#rhcop-ocp_bestpract-00005-container-does-not-set-java-xmx-option)
* [RHCOP-OCP_BESTPRACT-00006: Label key is consistent](#rhcop-ocp_bestpract-00006-label-key-is-consistent)
* [RHCOP-OCP_BESTPRACT-00007: Container liveness and readiness probes are equal](#rhcop-ocp_bestpract-00007-container-liveness-and-readiness-probes-are-equal)
* [RHCOP-OCP_BESTPRACT-00008: Container liveness prob is not set](#rhcop-ocp_bestpract-00008-container-liveness-prob-is-not-set)
* [RHCOP-OCP_BESTPRACT-00009: Container readiness prob is not set](#rhcop-ocp_bestpract-00009-container-readiness-prob-is-not-set)
* [RHCOP-OCP_BESTPRACT-00010: Container resource limits CPU not set](#rhcop-ocp_bestpract-00010-container-resource-limits-cpu-not-set)
* [RHCOP-OCP_BESTPRACT-00011: Container resource limits memory not greater than](#rhcop-ocp_bestpract-00011-container-resource-limits-memory-not-greater-than)
* [RHCOP-OCP_BESTPRACT-00012: Container resource limits memory not set](#rhcop-ocp_bestpract-00012-container-resource-limits-memory-not-set)
* [RHCOP-OCP_BESTPRACT-00013: Container resources limit memory has incorrect unit](#rhcop-ocp_bestpract-00013-container-resources-limit-memory-has-incorrect-unit)
* [RHCOP-OCP_BESTPRACT-00014: Container resources requests cpu has incorrect unit](#rhcop-ocp_bestpract-00014-container-resources-requests-cpu-has-incorrect-unit)
* [RHCOP-OCP_BESTPRACT-00015: Container resource requests memory not greater than](#rhcop-ocp_bestpract-00015-container-resource-requests-memory-not-greater-than)
* [RHCOP-OCP_BESTPRACT-00016: Container secret not mounted as envs](#rhcop-ocp_bestpract-00016-container-secret-not-mounted-as-envs)
* [RHCOP-OCP_BESTPRACT-00017: Container volume mount path is consistent](#rhcop-ocp_bestpract-00017-container-volume-mount-path-is-consistent)
* [RHCOP-OCP_BESTPRACT-00018: Container volume mount not set](#rhcop-ocp_bestpract-00018-container-volume-mount-not-set)
* [RHCOP-OCP_BESTPRACT-00019: DeploymentConfig triggers not set](#rhcop-ocp_bestpract-00019-deploymentconfig-triggers-not-set)
* [RHCOP-OCP_BESTPRACT-00020: Pod hostnetwork not set](#rhcop-ocp_bestpract-00020-pod-hostnetwork-not-set)
* [RHCOP-OCP_BESTPRACT-00021: Pod replica below 1](#rhcop-ocp_bestpract-00021-pod-replica-below-1)
* [RHCOP-OCP_BESTPRACT-00022: Pod replica is not odd](#rhcop-ocp_bestpract-00022-pod-replica-is-not-odd)
* [RHCOP-OCP_BESTPRACT-00023: RoleBinding has apiGroup set](#rhcop-ocp_bestpract-00023-rolebinding-has-apigroup-set)
* [RHCOP-OCP_BESTPRACT-00024: RoleBinding has kind set](#rhcop-ocp_bestpract-00024-rolebinding-has-kind-set)
* [RHCOP-OCP_BESTPRACT-00025: Route has TLS Termination Defined](#rhcop-ocp_bestpract-00025-route-has-tls-termination-defined)
* [RHCOP-OCP_BESTPRACT-00026: Pod anti-affinity not set](#rhcop-ocp_bestpract-00026-pod-anti-affinity-not-set)
* [RHCOP-OCP_BESTPRACT-00027: DeploymentConfig triggers container name miss match](#rhcop-ocp_bestpract-00027-deploymentconfig-triggers-container-name-miss-match)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00001: BuildConfig no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00001-buildconfig-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00002: DeploymentConfig no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00002-deploymentconfig-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00003: ImageStream no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00003-imagestream-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00004: ProjectRequest no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00004-projectrequest-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00005: RoleBinding no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00005-rolebinding-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00006: Route no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00006-route-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00007: SecurityContextConstraints no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00007-securitycontextconstraints-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp3_11-00008: Template no longer served by v1](#rhcop-ocp_deprecated-ocp3_11-00008-template-no-longer-served-by-v1)
* [RHCOP-OCP_DEPRECATED-ocp4_1-00001: BuildConfig exposeDockerSocket deprecated](#rhcop-ocp_deprecated-ocp4_1-00001-buildconfig-exposedockersocket-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00001: authorization openshift io is deprecated](#rhcop-ocp_deprecated-ocp4_2-00001-authorization-openshift-io-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00002: automationbroker io v1alpha1 is deprecated](#rhcop-ocp_deprecated-ocp4_2-00002-automationbroker-io-v1alpha1-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00003: operators coreos com v1 CatalogSourceConfigs is deprecated](#rhcop-ocp_deprecated-ocp4_2-00003-operators-coreos-com-v1-catalogsourceconfigs-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00004: operators coreos com v2 CatalogSourceConfigs is deprecated](#rhcop-ocp_deprecated-ocp4_2-00004-operators-coreos-com-v2-catalogsourceconfigs-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00005: operators coreos com v1 OperatorSource is deprecated](#rhcop-ocp_deprecated-ocp4_2-00005-operators-coreos-com-v1-operatorsource-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00006: osb openshift io v1 is deprecated](#rhcop-ocp_deprecated-ocp4_2-00006-osb-openshift-io-v1-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_2-00007: servicecatalog k8s io v1beta1 is deprecated](#rhcop-ocp_deprecated-ocp4_2-00007-servicecatalog-k8s-io-v1beta1-is-deprecated)
* [RHCOP-OCP_DEPRECATED-ocp4_3-00001: BuildConfig jenkinsPipelineStrategy is deprecated](#rhcop-ocp_deprecated-ocp4_3-00001-buildconfig-jenkinspipelinestrategy-is-deprecated)
* [RHCOP-OCP_REQ_INV-00001: Deployment has a matching PodDisruptionBudget](#rhcop-ocp_req_inv-00001-deployment-has-a-matching-poddisruptionbudget)
* [RHCOP-OCP_REQ_INV-00002: Deployment has matching PersistentVolumeClaim](#rhcop-ocp_req_inv-00002-deployment-has-matching-persistentvolumeclaim)
* [RHCOP-OCP_REQ_INV-00003: Deployment has a matching Service](#rhcop-ocp_req_inv-00003-deployment-has-a-matching-service)
* [RHCOP-OCP_REQ_INV-00004: Deployment has matching ServiceAccount](#rhcop-ocp_req_inv-00004-deployment-has-matching-serviceaccount)
* [RHCOP-OCP_REQ_INV-00005: Service has matching ServiceMonitor](#rhcop-ocp_req_inv-00005-service-has-matching-servicemonitor)
* [RHCOP-PODMAN-00001: Image contains expected SHA in history](#rhcop-podman-00001-image-contains-expected-sha-in-history)
* [RHCOP-PODMAN-00002: Image size is not greater than an expected value](#rhcop-podman-00002-image-size-is-not-greater-than-an-expected-value)

## RHCOP-COMBINE-00001: Namespace has a NetworkPolicy

**Severity:** Violation

**Resources:** core/Namespace networking.k8s.io/NetworkPolicy

Kubernetes network policies specify the access permissions for groups of pods,
much like security groups in the cloud are used to control access to VM instances.
In other words, it creates firewalls between pods running on a Kubernetes cluster.
See: Network policies -> https://learnk8s.io/production-best-practices#governance

### Rego

```rego
package combine.namespace_has_networkpolicy

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  some manifests in input
  some namespace in manifests

  lower(namespace.apiVersion) == "v1"
  lower(namespace.kind) == "namespace"

  not _has_networkpolicy(manifests)

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.6/networking/network_policy/about-network-policy.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00001")
}

_has_networkpolicy(manifests) {
  some current in manifests

  lower(current.apiVersion) == "networking.k8s.io/v1"
  lower(current.kind) == "networkpolicy"
}
```

_source: [policy/combine/namespace_has_networkpolicy](policy/combine/namespace_has_networkpolicy)_

## RHCOP-COMBINE-00002: Namespace has a ResourceQuota

**Severity:** Violation

**Resources:** core/Namespace core/ResourceQuota

With ResourceQuotas, you can limit the total resource consumption of all containers inside a Namespace.
Defining a resource quota for a namespace limits the total amount of CPU, memory or storage resources
that can be consumed by all containers belonging to that namespace. You can also set quotas for other
Kubernetes objects such as the number of Pods in the current namespace.
See: Namespace limits -> https://learnk8s.io/production-best-practices#governance

### Rego

```rego
package combine.namespace_has_resourcequota

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  some manifests in input
  some namespace in manifests

  lower(namespace.apiVersion) == "v1"
  lower(namespace.kind) == "namespace"

  not _has_resourcequota(manifests)

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a core/v1:ResourceQuota. See: https://docs.openshift.com/container-platform/4.6/applications/quotas/quotas-setting-per-project.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00002")
}

_has_resourcequota(manifests) {
  some current in manifests

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "resourcequota"
}
```

_source: [policy/combine/namespace_has_resourcequota](policy/combine/namespace_has_resourcequota)_

## RHCOP-OCP_BESTPRACT-00001: Common k8s labels are set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController core/Service apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob route.openshift.io/Route

Check if all workload related kinds contain labels as suggested by k8s.
See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels

### Rego

```rego
package ocp.bestpractices.common_k8s_labels_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00001")
  openshift.is_pod_or_networking

  not _is_common_labels_set(konstraint_core.resource.metadata)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00001")
}

_is_common_labels_set(metadata) {
  metadata.labels["app.kubernetes.io/name"]
  metadata.labels["app.kubernetes.io/instance"]
  metadata.labels["app.kubernetes.io/version"]
  metadata.labels["app.kubernetes.io/component"]
  metadata.labels["app.kubernetes.io/part-of"]
  metadata.labels["app.kubernetes.io/managed-by"]
}
```

_source: [policy/ocp/bestpractices/common_k8s_labels_notset](policy/ocp/bestpractices/common_k8s_labels_notset)_

## RHCOP-OCP_BESTPRACT-00002: Container env has CONTAINER_MAX_MEMORY set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
Instead of manually setting -Xmx, let the image automatically set it for you.
See: https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options

### Rego

```rego
package ocp.bestpractices.container_env_maxmemory_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00002")
  some container in openshift.containers

  konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
  not _is_env_max_memory_set(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.6/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00002")
}

_is_env_max_memory_set(container) {
  some env in container.env
  env.name == "CONTAINER_MAX_MEMORY"
  env.valueFrom.resourceFieldRef.resource == "limits.memory"
}
```

_source: [policy/ocp/bestpractices/container_env_maxmemory_notset](policy/ocp/bestpractices/container_env_maxmemory_notset)_

## RHCOP-OCP_BESTPRACT-00003: Container image is not set as latest

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Images should use immutable tags. Today's latest is not tomorrows latest.

### Rego

```rego
package ocp.bestpractices.container_image_latest

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00003")
  some container in openshift.containers

  endswith(container.image, ":latest")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' is using the latest tag for its image (%s), which is an anti-pattern.", [konstraint_core.kind, konstraint_core.name, container.name, container.image]), "RHCOP-OCP_BESTPRACT-00003")
}
```

_source: [policy/ocp/bestpractices/container_image_latest](policy/ocp/bestpractices/container_image_latest)_

## RHCOP-OCP_BESTPRACT-00004: Container image is not from a known registry

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Only images from trusted and known registries should be used

### Rego

```rego
package ocp.bestpractices.container_image_unknownregistries

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00004")
  some container in openshift.containers

  registry := _resolve_registry(container.image)
  not _known_registry(registry)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' is from (%s), which is an unknown registry.", [konstraint_core.kind, konstraint_core.name, container.name, container.image]), "RHCOP-OCP_BESTPRACT-00004")
}

_resolve_registry(image) := registry {
  contains(image, "/")
  registry := lower(split(image, "/")[0])

  # Check its an external URL and not internal OCP registry ref
  contains(registry, ".")
}

_known_registry(registry) {
  known_registries := ["image-registry.openshift-image-registry.svc", "registry.redhat.io", "registry.connect.redhat.com", "quay.io"]
  registry in known_registries
}
```

_source: [policy/ocp/bestpractices/container_image_unknownregistries](policy/ocp/bestpractices/container_image_unknownregistries)_

## RHCOP-OCP_BESTPRACT-00005: Container does not set Java Xmx option

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
Instead of manually setting -Xmx, let the image automatically set it for you.

### Rego

```rego
package ocp.bestpractices.container_java_xmx_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00005")
  some container in openshift.containers

  konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
  _container_opts_contains_xmx(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00005")
}

_container_opts_contains_xmx(container) {
  some command in container.command
  contains(command, "-Xmx")
}

_container_opts_contains_xmx(container) {
  some arg in container.args
  contains(arg, "-Xmx")
}

_container_opts_contains_xmx(container) {
  some env in container.env
  contains(env.value, "-Xmx")
}
```

_source: [policy/ocp/bestpractices/container_java_xmx_set](policy/ocp/bestpractices/container_java_xmx_set)_

## RHCOP-OCP_BESTPRACT-00006: Label key is consistent

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Label keys should be qualified by 'app.kubernetes.io' or 'company.com' to allow a consistent understanding.

### Rego

```rego
package ocp.bestpractices.container_labelkey_inconsistent

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00006")
  openshift.pod

  some key

  # regal ignore:prefer-some-in-iteration
  value := konstraint_core.labels[key]

  not _label_key_starts_with_expected(key)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found '%s=%s'", [konstraint_core.kind, konstraint_core.name, key, value]), "RHCOP-OCP_BESTPRACT-00006")
}

_label_key_starts_with_expected(key) {
  startswith(key, "app.kubernetes.io/")
}

_label_key_starts_with_expected(key) {
  startswith(key, "redhat-cop.github.com/")
}
```

_source: [policy/ocp/bestpractices/container_labelkey_inconsistent](policy/ocp/bestpractices/container_labelkey_inconsistent)_

## RHCOP-OCP_BESTPRACT-00007: Container liveness and readiness probes are equal

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

When Liveness and Readiness probes are pointing to the same endpoint, the effects of the probes are combined.
When the app signals that it's not ready or live, the kubelet detaches the container from the Service
and delete it at the same time. You might notice dropping connections because the container
does not have enough time to drain the current connections or process the incoming ones.
See: Health checks -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.container_liveness_readinessprobe_equal

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00007")
  some container in openshift.containers

  container.livenessProbe == container.readinessProbe

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00007")
}
```

_source: [policy/ocp/bestpractices/container_liveness_readinessprobe_equal](policy/ocp/bestpractices/container_liveness_readinessprobe_equal)_

## RHCOP-OCP_BESTPRACT-00008: Container liveness prob is not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

A Liveness checks determines if the container in which it is scheduled is still running.
If the liveness probe fails due to a condition such as a deadlock, the kubelet kills the container.
See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html

### Rego

```rego
package ocp.bestpractices.container_livenessprobe_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00008")
  some container in openshift.containers

  konstraint_core.missing_field(container, "livenessProbe")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00008")
}
```

_source: [policy/ocp/bestpractices/container_livenessprobe_notset](policy/ocp/bestpractices/container_livenessprobe_notset)_

## RHCOP-OCP_BESTPRACT-00009: Container readiness prob is not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

A Readiness check determines if the container in which it is scheduled is ready to service requests.
If the readiness probe fails a container, the endpoints controller ensures the container has its IP address
removed from the endpoints of all services.
See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html

### Rego

```rego
package ocp.bestpractices.container_readinessprobe_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00009")
  some container in openshift.containers

  konstraint_core.missing_field(container, "readinessProbe")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00009")
}
```

_source: [policy/ocp/bestpractices/container_readinessprobe_notset](policy/ocp/bestpractices/container_readinessprobe_notset)_

## RHCOP-OCP_BESTPRACT-00010: Container resource limits CPU not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

If you're not sure about what's the best settings for your app, it's better not to set the CPU limits.
See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
See: reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits

### Rego

```rego
package ocp.bestpractices.container_resources_limits_cpu_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00010")
  some container in openshift.containers

  container.resources.limits.cpu

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has cpu limits (%d). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.cpu]), "RHCOP-OCP_BESTPRACT-00010")
}
```

_source: [policy/ocp/bestpractices/container_resources_limits_cpu_set](policy/ocp/bestpractices/container_resources_limits_cpu_set)_

## RHCOP-OCP_BESTPRACT-00011: Container resource limits memory not greater than

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Setting a too high memory limit can cause under utilisation on a node.
It is better to run multiple pods which use smaller limits.
See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.container_resources_limits_memory_greater_than

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.memory
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00011")

  # NOTE: upper_bound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upper_bound := 6 * memory.gb

  some container in openshift.containers

  not startswith(container.resources.limits.memory, "$")
  memory_bytes := units.parse_bytes(container.resources.limits.memory)
  memory_bytes > upper_bound

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a memory limit of '%s' which is larger than the upper '%dGi' limit.", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.memory, upper_bound / memory.gb]), "RHCOP-OCP_BESTPRACT-00011")
}
```

_source: [policy/ocp/bestpractices/container_resources_limits_memory_greater_than](policy/ocp/bestpractices/container_resources_limits_memory_greater_than)_

## RHCOP-OCP_BESTPRACT-00012: Container resource limits memory not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

A container without a memory limit has memory utilisation of zero — according to the scheduler.
An unlimited number of Pods if schedulable on any nodes leading to resource overcommitment
and potential node (and kubelet) crashes.
See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.container_resources_limits_memory_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00012")
  some container in openshift.containers

  not container.resources.limits.memory

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00012")
}
```

_source: [policy/ocp/bestpractices/container_resources_limits_memory_notset](policy/ocp/bestpractices/container_resources_limits_memory_notset)_

## RHCOP-OCP_BESTPRACT-00013: Container resources limit memory has incorrect unit

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Begininers can easily confuse the allowed memory unit, this policy enforces what is valid.
k8s also allows for millibyte as a unit for memory, which causes unintended consequences for the scheduler.
See: https://github.com/kubernetes/kubernetes/issues/28741
See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes

### Rego

```rego
package ocp.bestpractices.container_resources_memoryunit_incorrect

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00013")
  some container in openshift.containers

  not startswith(container.resources.requests.memory, "$")
  not startswith(container.resources.limits.memory, "$")
  not _is_resource_memory_units_valid(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' memory resources for limits or requests (%s / %s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.memory, container.resources.requests.memory]), "RHCOP-OCP_BESTPRACT-00013")
}

_is_resource_memory_units_valid(container) {
  limits_unit := regex.find_n(`[A-Za-z]+`, container.resources.limits.memory, 1)[0]
  requests_unit := regex.find_n(`[A-Za-z]+`, container.resources.requests.memory, 1)[0]

  memory_units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
  limits_unit in memory_units
  requests_unit in memory_units
}
```

_source: [policy/ocp/bestpractices/container_resources_memoryunit_incorrect](policy/ocp/bestpractices/container_resources_memoryunit_incorrect)_

## RHCOP-OCP_BESTPRACT-00014: Container resources requests cpu has incorrect unit

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Beginners can easily confuse the allowed cpu unit, this policy enforces what is valid.
See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes

### Rego

```rego
package ocp.bestpractices.container_resources_requests_cpuunit_incorrect

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00014")
  some container in openshift.containers

  not is_resource_requests_cpu_contains_dollar(container)
  not is_resource_requests_cpu_units_valid(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s container '%s' cpu resources for requests (%s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.cpu]), "RHCOP-OCP_BESTPRACT-00014")
}

is_resource_requests_cpu_contains_dollar(container) {
  not is_number(container.resources.requests.cpu)
  startswith(container.resources.requests.cpu, "$")
}

is_resource_requests_cpu_units_valid(container) {
  is_number(container.resources.requests.cpu)
}

is_resource_requests_cpu_units_valid(container) {
  not is_number(container.resources.requests.cpu)

  # 'cpu' can be a quoted number, which is why we concat an empty string[] to match whole cpu cores
  requests_unit := array.concat(regex.find_n(`[A-Za-z]+`, container.resources.requests.cpu, 1), [""])[0]

  requests_unit in {"m", ""}
}
```

_source: [policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect](policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect)_

## RHCOP-OCP_BESTPRACT-00015: Container resource requests memory not greater than

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Setting a too high memory request can cause under utilisation on a node.
It is better to run multiple pods which use smaller requests.
See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.container_resources_requests_memory_greater_than

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.memory
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00015")

  # NOTE: upper_bound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upper_bound := 2 * memory.gb

  some container in openshift.containers

  not startswith(container.resources.requests.memory, "$")
  memory_bytes := units.parse_bytes(container.resources.requests.memory)
  memory_bytes > upper_bound

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a memory request of '%s' which is larger than the upper '%dGi' limit.", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.memory, upper_bound / memory.gb]), "RHCOP-OCP_BESTPRACT-00015")
}
```

_source: [policy/ocp/bestpractices/container_resources_requests_memory_greater_than](policy/ocp/bestpractices/container_resources_requests_memory_greater_than)_

## RHCOP-OCP_BESTPRACT-00016: Container secret not mounted as envs

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

The content of Secret resources should be mounted into containers as volumes rather than,
passed in as environment variables. This is to prevent that the secret values appear in the command that was
used to start the container, which may be inspected by individuals that shouldn't have access to the secret values.
See: Configuration and secrets -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.container_secret_mounted_envs

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00016")
  some container in openshift.containers

  some env in container.env
  env.valueFrom.secretKeyRef

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. Secrets are meant to be secret, it is not a good practice to mount them as env vars.", [konstraint_core.kind, konstraint_core.name, container.name, env.valueFrom.secretKeyRef.name]), "RHCOP-OCP_BESTPRACT-00016")
}
```

_source: [policy/ocp/bestpractices/container_secret_mounted_envs](policy/ocp/bestpractices/container_secret_mounted_envs)_

## RHCOP-OCP_BESTPRACT-00017: Container volume mount path is consistent

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Mount paths should be mounted at '/var/run/company.com' to allow a consistent understanding.

### Rego

```rego
package ocp.bestpractices.container_volumemount_inconsistent_path

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00017")
  some container in openshift.containers

  some volume_mount in container.volumeMounts
  not startswith(volume_mount.mountPath, "/var/run")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a volumeMount '%s' mountPath at '%s'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret", [konstraint_core.kind, konstraint_core.name, container.name, volume_mount.name, volume_mount.mountPath]), "RHCOP-OCP_BESTPRACT-00017")
}
```

_source: [policy/ocp/bestpractices/container_volumemount_inconsistent_path](policy/ocp/bestpractices/container_volumemount_inconsistent_path)_

## RHCOP-OCP_BESTPRACT-00018: Container volume mount not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

A volume does not have a corresponding volume mount. There is probably a mistake in your definition.

### Rego

```rego
package ocp.bestpractices.container_volumemount_missing

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00018")
  some volume in openshift.pod.spec.volumes

  not _containers_volumemounts_contains_volume(openshift.containers, volume)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [konstraint_core.kind, konstraint_core.name, volume.name]), "RHCOP-OCP_BESTPRACT-00018")
}

_containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}
```

_source: [policy/ocp/bestpractices/container_volumemount_missing](policy/ocp/bestpractices/container_volumemount_missing)_

## RHCOP-OCP_BESTPRACT-00019: DeploymentConfig triggers not set

**Severity:** Violation

**Resources:** apps.openshift.io/DeploymentConfig

If you are using a DeploymentConfig without 'spec.triggers' set, you could probably just use the k8s Deployment.

### Rego

```rego
package ocp.bestpractices.deploymentconfig_triggers_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_deploymentconfig

  konstraint_core.missing_field(konstraint_core.resource.spec, "triggers")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00019")
}
```

_source: [policy/ocp/bestpractices/deploymentconfig_triggers_notset](policy/ocp/bestpractices/deploymentconfig_triggers_notset)_

## RHCOP-OCP_BESTPRACT-00020: Pod hostnetwork not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig batch/CronJob

Pods which require 'spec.hostNetwork' should be limited due to security concerns.

### Rego

```rego
package ocp.bestpractices.pod_hostnetwork

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00020")
  openshift.pod.spec.hostNetwork

  msg := konstraint_core.format_with_id(sprintf("%s/%s: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00020")
}
```

_source: [policy/ocp/bestpractices/pod_hostnetwork](policy/ocp/bestpractices/pod_hostnetwork)_

## RHCOP-OCP_BESTPRACT-00021: Pod replica below 1

**Severity:** Violation

**Resources:** apps/Deployment apps.openshift.io/DeploymentConfig

Never run a single Pod individually.
See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.pod_replicas_below_one

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00021")
  openshift.pod

  replicas := konstraint_core.resource.spec.replicas
  replicas <= 1

  msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected replicas to be greater than 1 for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00021")
}
```

_source: [policy/ocp/bestpractices/pod_replicas_below_one](policy/ocp/bestpractices/pod_replicas_below_one)_

## RHCOP-OCP_BESTPRACT-00022: Pod replica is not odd

**Severity:** Violation

**Resources:** apps/Deployment apps.openshift.io/DeploymentConfig

Pods should be run with a replica which is odd, i.e.: 3, 5, 7, etc, for HA guarantees.
See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development

### Rego

```rego
package ocp.bestpractices.pod_replicas_not_odd

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00022")
  openshift.pod

  replicas := konstraint_core.resource.spec.replicas
  replicas % 2 == 0

  msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00022")
}
```

_source: [policy/ocp/bestpractices/pod_replicas_not_odd](policy/ocp/bestpractices/pod_replicas_not_odd)_

## RHCOP-OCP_BESTPRACT-00023: RoleBinding has apiGroup set

**Severity:** Violation

**Resources:** rbac.authorization.k8s.io/RoleBinding

Migrating from 3.11 to 4.x requires the 'roleRef.apiGroup' to be set.

### Rego

```rego
package ocp.bestpractices.rolebinding_roleref_apigroup_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

violation[msg] {
  kubernetes.is_rolebinding

  konstraint_core.missing_field(konstraint_core.resource.roleRef, "apiGroup")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00023")
}
```

_source: [policy/ocp/bestpractices/rolebinding_roleref_apigroup_notset](policy/ocp/bestpractices/rolebinding_roleref_apigroup_notset)_

## RHCOP-OCP_BESTPRACT-00024: RoleBinding has kind set

**Severity:** Violation

**Resources:** rbac.authorization.k8s.io/RoleBinding

Migrating from 3.11 to 4.x requires the 'roleRef.kind' to be set.

### Rego

```rego
package ocp.bestpractices.rolebinding_roleref_kind_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

violation[msg] {
  kubernetes.is_rolebinding

  konstraint_core.missing_field(konstraint_core.resource.roleRef, "kind")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00024")
}
```

_source: [policy/ocp/bestpractices/rolebinding_roleref_kind_notset](policy/ocp/bestpractices/rolebinding_roleref_kind_notset)_

## RHCOP-OCP_BESTPRACT-00025: Route has TLS Termination Defined

**Severity:** Violation

**Resources:** route.openshift.io/Route

Routes should specify a TLS termination type to allow only secure ingress.

### Rego

```rego
package ocp.bestpractices.route_tls_termination_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00025")
  openshift.is_route

  not konstraint_core.resource.spec.tls.termination

  msg := konstraint_core.format_with_id(sprintf("%s/%s: TLS termination type not set. See https://docs.openshift.com/container-platform/4.6/networking/routes/secured-routes.html", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00025")
}
```

_source: [policy/ocp/bestpractices/route_tls_termination_notset](policy/ocp/bestpractices/route_tls_termination_notset)_

## RHCOP-OCP_BESTPRACT-00026: Pod anti-affinity not set

**Severity:** Violation

**Resources:** core/Pod core/ReplicationController apps/Deployment apps/ReplicaSet apps/StatefulSet apps.openshift.io/DeploymentConfig

Even if you run several copies of your Pods,
there are no guarantees that losing a node won't take down your service. Anti-Affinity helps here.
See: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity

### Rego

```rego
package ocp.bestpractices.pod_antiaffinity_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00026")
  openshift.pod

  pod_spec := openshift.pod.spec
  konstraint_core.missing_field(pod_spec.affinity, "podAntiAffinity")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: spec.affinity.podAntiAffinity not set. See: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00026")
}
```

_source: [policy/ocp/bestpractices/pod_antiaffinity_notset](policy/ocp/bestpractices/pod_antiaffinity_notset)_

## RHCOP-OCP_BESTPRACT-00027: DeploymentConfig triggers container name miss match

**Severity:** Violation

**Resources:** apps.openshift.io/DeploymentConfig

If you are using a DeploymentConfig with 'spec.triggers' set,
but the container name does not match the trigger will never fire. There is probably a mistake in your definition.

### Rego

```rego
package ocp.bestpractices.deploymentconfig_triggers_containername

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00027")
  openshift.is_deploymentconfig

  some trigger in konstraint_core.resource.spec.triggers
  some container_name in trigger.imageChangeParams.containerNames

  not _containers_contains_trigger(openshift.containers, container_name)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has a imageChangeParams trigger with a miss-matching container name for '%s'", [konstraint_core.kind, konstraint_core.name, container_name]), "RHCOP-OCP_BESTPRACT-00027")
}

_containers_contains_trigger(containers, container_name) {
  some container in containers
  container.name == container_name
}
```

_source: [policy/ocp/bestpractices/deploymentconfig_triggers_containername](policy/ocp/bestpractices/deploymentconfig_triggers_containername)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00001: BuildConfig no longer served by v1

**Severity:** Violation

**Resources:** v1/BuildConfig

OCP4.x expects build.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.buildconfig_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "buildconfig"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00001")
}
```

_source: [policy/ocp/deprecated/ocp3_11/buildconfig_v1](policy/ocp/deprecated/ocp3_11/buildconfig_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00002: DeploymentConfig no longer served by v1

**Severity:** Violation

**Resources:** v1/DeploymentConfig

OCP4.x expects apps.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.deploymentconfig_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "deploymentconfig"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00002")
}
```

_source: [policy/ocp/deprecated/ocp3_11/deploymentconfig_v1](policy/ocp/deprecated/ocp3_11/deploymentconfig_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00003: ImageStream no longer served by v1

**Severity:** Violation

**Resources:** v1/ImageStream

OCP4.x expects image.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.imagestream_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "imagestream"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00003")
}
```

_source: [policy/ocp/deprecated/ocp3_11/imagestream_v1](policy/ocp/deprecated/ocp3_11/imagestream_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00004: ProjectRequest no longer served by v1

**Severity:** Violation

**Resources:** v1/ProjectRequest

OCP4.x expects project.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.projectrequest_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "projectrequest"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00004")
}
```

_source: [policy/ocp/deprecated/ocp3_11/projectrequest_v1](policy/ocp/deprecated/ocp3_11/projectrequest_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00005: RoleBinding no longer served by v1

**Severity:** Violation

**Resources:** v1/RoleBinding

OCP4.x expects rbac.authorization.k8s.io/v1

### Rego

```rego
package ocp.deprecated.ocp3_11.rolebinding_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "rolebinding"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00005")
}
```

_source: [policy/ocp/deprecated/ocp3_11/rolebinding_v1](policy/ocp/deprecated/ocp3_11/rolebinding_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00006: Route no longer served by v1

**Severity:** Violation

**Resources:** v1/Route

OCP4.x expects route.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.route_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "route"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00006")
}
```

_source: [policy/ocp/deprecated/ocp3_11/route_v1](policy/ocp/deprecated/ocp3_11/route_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00007: SecurityContextConstraints no longer served by v1

**Severity:** Violation

**Resources:** v1/SecurityContextConstraints

OCP4.x expects security.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.securitycontextconstraints_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "securitycontextconstraints"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00007")
}
```

_source: [policy/ocp/deprecated/ocp3_11/securitycontextconstraints_v1](policy/ocp/deprecated/ocp3_11/securitycontextconstraints_v1)_

## RHCOP-OCP_DEPRECATED-ocp3_11-00008: Template no longer served by v1

**Severity:** Violation

**Resources:** v1/Template

OCP4.x expects template.openshift.io/v1.

### Rego

```rego
package ocp.deprecated.ocp3_11.template_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "template"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00008")
}
```

_source: [policy/ocp/deprecated/ocp3_11/template_v1](policy/ocp/deprecated/ocp3_11/template_v1)_

## RHCOP-OCP_DEPRECATED-ocp4_1-00001: BuildConfig exposeDockerSocket deprecated

**Severity:** Violation

**Resources:** build.openshift.io/BuildConfig

'spec.strategy.customStrategy.exposeDockerSocket' is no longer supported by BuildConfig.
See: https://docs.openshift.com/container-platform/4.1/release_notes/ocp-4-1-release-notes.html#ocp-41-deprecated-features

### Rego

```rego
package ocp.deprecated.ocp4_1.buildconfig_custom_strategy

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "build.openshift.io/v1"
  lower(konstraint_core.kind) == "buildconfig"

  konstraint_core.resource.spec.strategy.customStrategy.exposeDockerSocket

  msg := konstraint_core.format_with_id(sprintf("%s/%s: 'spec.strategy.customStrategy.exposeDockerSocket' is deprecated. If you want to continue using custom builds, you should replace your Docker invocations with Podman or Buildah.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.1-00001")
}
```

_source: [policy/ocp/deprecated/ocp4_1/buildconfig_custom_strategy](policy/ocp/deprecated/ocp4_1/buildconfig_custom_strategy)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00001: authorization openshift io is deprecated

**Severity:** Violation

**Resources:** authorization.openshift.io/ClusterRole authorization.openshift.io/ClusterRoleBinding authorization.openshift.io/Role authorization.openshift.io/RoleBinding

From OCP4.2 onwards, you should migrate from 'authorization.openshift.io' to rbac.authorization.k8s.io/v1.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features

### Rego

```rego
package ocp.deprecated.ocp4_2.authorization_openshift

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "authorization.openshift.io")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API authorization.openshift.io for ClusterRole, ClusterRoleBinding, Role and RoleBinding is deprecated, use rbac.authorization.k8s.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00001")
}
```

_source: [policy/ocp/deprecated/ocp4_2/authorization_openshift](policy/ocp/deprecated/ocp4_2/authorization_openshift)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00002: automationbroker io v1alpha1 is deprecated

**Severity:** Violation

**Resources:** automationbroker.io/Bundle automationbroker.io/BundleBinding automationbroker.io/BundleInstance

'automationbroker.io/v1alpha1' is deprecated in OCP 4.2 and removed in 4.4.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
See: https://docs.openshift.com/container-platform/4.4/release_notes/ocp-4-4-release-notes.html#ocp-4-4-deprecated-removed-features

### Rego

```rego
package ocp.deprecated.ocp4_2.automationbroker_v1alpha1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "automationbroker.io/v1alpha1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00002")
}
```

_source: [policy/ocp/deprecated/ocp4_2/automationbroker_v1alpha1](policy/ocp/deprecated/ocp4_2/automationbroker_v1alpha1)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00003: operators coreos com v1 CatalogSourceConfigs is deprecated

**Severity:** Violation

**Resources:** operators.coreos.com/CatalogSourceConfigs

'operators.coreos.com/v1:CatalogSourceConfigs' is deprecated in OCP 4.2 and removed in 4.5.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features

### Rego

```rego
package ocp.deprecated.ocp4_2.catalogsourceconfigs_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "operators.coreos.com/v1")
  lower(konstraint_core.kind) == "catalogsourceconfigs"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00003")
}
```

_source: [policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v1](policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v1)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00004: operators coreos com v2 CatalogSourceConfigs is deprecated

**Severity:** Violation

**Resources:** operators.coreos.com/CatalogSourceConfigs

'operators.coreos.com/v2:CatalogSourceConfigs' is deprecated in OCP 4.2 and removed in 4.5.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features

### Rego

```rego
package ocp.deprecated.ocp4_2.catalogsourceconfigs_v2

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "operators.coreos.com/v2")
  lower(konstraint_core.kind) == "catalogsourceconfigs"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: operators.coreos.com/v2 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00004")
}
```

_source: [policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v2](policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v2)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00005: operators coreos com v1 OperatorSource is deprecated

**Severity:** Violation

**Resources:** operators.coreos.com/OperatorSource

'operators.coreos.com/v1:OperatorSource' is deprecated in OCP 4.2 and will be removed in a future version.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features

### Rego

```rego
package ocp.deprecated.ocp4_2.operatorsources_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "operators.coreos.com/v1")
  lower(konstraint_core.kind) == "operatorsource"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00005")
}
```

_source: [policy/ocp/deprecated/ocp4_2/operatorsources_v1](policy/ocp/deprecated/ocp4_2/operatorsources_v1)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00006: osb openshift io v1 is deprecated

**Severity:** Violation

**Resources:** osb.openshift.io/AutomationBroker osb.openshift.io/TemplateServiceBroker

'osb.openshift.io/v1' is deprecated in OCP 4.2 and removed in 4.5.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features

### Rego

```rego
package ocp.deprecated.ocp4_2.osb_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "osb.openshift.io/v1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: osb.openshift.io/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00006")
}
```

_source: [policy/ocp/deprecated/ocp4_2/osb_v1](policy/ocp/deprecated/ocp4_2/osb_v1)_

## RHCOP-OCP_DEPRECATED-ocp4_2-00007: servicecatalog k8s io v1beta1 is deprecated

**Severity:** Violation

**Resources:** servicecatalog.k8s.io/ClusterServiceBroker servicecatalog.k8s.io/ClusterServiceClass servicecatalog.k8s.io/ClusterServicePlan servicecatalog.k8s.io/ServiceBinding servicecatalog.k8s.io/ServiceInstance

'servicecatalog.k8s.io/v1beta1' is deprecated in OCP 4.2 and removed in 4.5.
See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features

### Rego

```rego
package ocp.deprecated.ocp4_2.servicecatalog_v1beta1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "servicecatalog.k8s.io/v1beta1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00007")
}
```

_source: [policy/ocp/deprecated/ocp4_2/servicecatalog_v1beta1](policy/ocp/deprecated/ocp4_2/servicecatalog_v1beta1)_

## RHCOP-OCP_DEPRECATED-ocp4_3-00001: BuildConfig jenkinsPipelineStrategy is deprecated

**Severity:** Violation

**Resources:** build.openshift.io/BuildConfig

'spec.strategy.jenkinsPipelineStrategy' is no longer supported by BuildConfig.
See: https://docs.openshift.com/container-platform/4.3/release_notes/ocp-4-3-release-notes.html#ocp-4-3-deprecated-features

### Rego

```rego
package ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "build.openshift.io/v1"
  lower(konstraint_core.kind) == "buildconfig"

  konstraint_core.resource.spec.strategy.jenkinsPipelineStrategy

  msg := konstraint_core.format_with_id(sprintf("%s/%s: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.3-00001")
}
```

_source: [policy/ocp/deprecated/ocp4_3/buildconfig_jenkinspipeline_strategy](policy/ocp/deprecated/ocp4_3/buildconfig_jenkinspipeline_strategy)_

## RHCOP-OCP_REQ_INV-00001: Deployment has a matching PodDisruptionBudget

**Severity:** Violation

**Resources:** apps/Deployment

All Deployments should have matching PodDisruptionBudget, via 'spec.template.metadata.labels', to provide HA guarantees.
See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/

### Rego

```rego
package ocp.requiresinventory.deployment_has_matching_poddisruptionbudget

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00001")
  kubernetes.is_deployment

  deployment := konstraint_core.resource

  not _has_matching_poddisruptionbudget(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a policy/v1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00001")
}

_has_matching_poddisruptionbudget(deployment, manifests) {
  cached := manifests["policy/v1"].PodDisruptionBudget
  some current in cached

  deployment.spec.template.metadata.labels == current.spec.selector.matchLabels
}
```

_source: [policy/ocp/requiresinventory/deployment_has_matching_poddisruptionbudget](policy/ocp/requiresinventory/deployment_has_matching_poddisruptionbudget)_

## RHCOP-OCP_REQ_INV-00002: Deployment has matching PersistentVolumeClaim

**Severity:** Violation

**Resources:** apps/Deployment

If Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there should be matching PersistentVolumeClaim.
If not, this would suggest a mistake.

### Rego

```rego
package ocp.requiresinventory.deployment_has_matching_pvc

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00002")
  kubernetes.is_deployment

  deployment := konstraint_core.resource
  _has_persistentvolumeclaim(deployment.spec.template.spec.volumes)

  not _has_matching_persistentvolumeclaim(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim.", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00002")
}

_has_persistentvolumeclaim(volumes) {
  some volume in volumes
  volume.persistentVolumeClaim
}

_has_matching_persistentvolumeclaim(deployment, manifests) {
  cached := manifests.v1.PersistentVolumeClaim
  some current in cached

  some volume in deployment.spec.template.spec.volumes
  volume.persistentVolumeClaim.claimName == current.metadata.name
}
```

_source: [policy/ocp/requiresinventory/deployment_has_matching_pvc](policy/ocp/requiresinventory/deployment_has_matching_pvc)_

## RHCOP-OCP_REQ_INV-00003: Deployment has a matching Service

**Severity:** Violation

**Resources:** apps/Deployment

All Deployments should have matching Service, via 'spec.template.metadata.labels'.
Deployments without a Service are not accessible and should be questioned as to why.

### Rego

```rego
package ocp.requiresinventory.deployment_has_matching_service

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00003")
  kubernetes.is_deployment

  deployment := konstraint_core.resource

  not _deployment_labels_matches_service_selector(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00003")
}

_deployment_labels_matches_service_selector(deployment, manifests) {
  cached := manifests.v1.Service
  some current in cached

  deployment.spec.template.metadata.labels == current.spec.selector
}
```

_source: [policy/ocp/requiresinventory/deployment_has_matching_service](policy/ocp/requiresinventory/deployment_has_matching_service)_

## RHCOP-OCP_REQ_INV-00004: Deployment has matching ServiceAccount

**Severity:** Violation

**Resources:** apps/Deployment

If Deployment has 'spec.serviceAccountName' set, there should be matching ServiceAccount.
If not, this would suggest a mistake.

### Rego

```rego
package ocp.requiresinventory.deployment_has_matching_serviceaccount

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00004")
  kubernetes.is_deployment

  deployment := konstraint_core.resource
  deployment.spec.template.spec.serviceAccountName

  not _has_matching_serviceaccount(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s has spec.serviceAccountName '%s' but could not find corrasponding v1:ServiceAccount.", [deployment.kind, deployment.metadata.name, deployment.spec.template.spec.serviceAccountName]), "RHCOP-OCP_REQ_INV-00004")
}

_has_matching_serviceaccount(deployment, manifests) {
  cached := manifests.v1.ServiceAccount
  some current in cached

  deployment.spec.template.spec.serviceAccountName == current.metadata.name
}
```

_source: [policy/ocp/requiresinventory/deployment_has_matching_serviceaccount](policy/ocp/requiresinventory/deployment_has_matching_serviceaccount)_

## RHCOP-OCP_REQ_INV-00005: Service has matching ServiceMonitor

**Severity:** Violation

**Resources:** core/Service

All Service should have a matching ServiceMonitor, via 'spec.selector'.
Service without a ServiceMonitor are not being monitored and should be questioned as to why.

### Rego

```rego
package ocp.requiresinventory.service_has_matching_servicemonitor

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00005")
  kubernetes.is_service

  service := konstraint_core.resource

  not _service_has_matching_servicemonitor(service, data.inventory.namespace[service.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html", [service.kind, service.metadata.name]), "RHCOP-OCP_REQ_INV-00005")
}

_service_has_matching_servicemonitor(service, manifests) {
  cached := manifests["monitoring.coreos.com/v1"].ServiceMonitor
  some current in cached

  service.spec.selector == current.spec.selector.matchLabels
}
```

_source: [policy/ocp/requiresinventory/service_has_matching_servicemonitor](policy/ocp/requiresinventory/service_has_matching_servicemonitor)_

## RHCOP-PODMAN-00001: Image contains expected SHA in history

**Severity:** Violation

**Resources:** redhat-cop.github.com/PodmanHistory

Most images are built from a subset of authorised base images in a company,
this policy allows enforcement of that policy by checking for an expected SHA.

parameter expected_layer_ids array string

### Rego

```rego
package podman.history.contains_layer

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanhistory"

  not _image_history_contains_layer(input.items, data.parameters.expected_layer_ids)

  msg := konstraint_core.format_with_id(sprintf("%s: did not find expected SHA.", [input.image]), "RHCOP-PODMAN-00001")
}

_image_history_contains_layer(layers, expected_layer_ids) {
  some layer in layers
  some expected_layer_id in expected_layer_ids
  layer.id == expected_layer_id
}
```

_source: [policy/podman/history/contains_layer](policy/podman/history/contains_layer)_

## RHCOP-PODMAN-00002: Image size is not greater than an expected value

**Severity:** Violation

**Resources:** redhat-cop.github.com/PodmanImages

Typically, the "smaller the better" rule applies to images so lets enforce that.

parameter image_size_upperbound integer

### Rego

```rego
package podman.images.image_size_not_greater_than

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.memory

violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanimages"

  some image in input.items
  size_mb := image.size / memory.mb
  size_mb > data.parameters.image_size_upperbound

  msg := konstraint_core.format_with_id(sprintf("%s: has a size of '%fMi', which is greater than '%dMi' limit.", [input.image, size_mb, data.parameters.image_size_upperbound]), "RHCOP-PODMAN-00002")
}
```

_source: [policy/podman/images/image_size_not_greater_than](policy/podman/images/image_size_not_greater_than)_

