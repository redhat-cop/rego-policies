# Policies

|API Groups|Kinds|Description|
|---|---|---|
|apps, policy|Deployment, PodDisruptionBudget|violation: Check if a Deployment has a matching policy/v1beta1:PodDisruptionBudget, via 'spec.template.metadata.labels'|
|apps, core|Deployment, PersistentVolumeClaim|violation: Check if a Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there is a matching v1:PersistentVolumeClaim|
|apps, core|Deployment, Service|violation: Check if a Deployment has a matching v1:Service, via 'spec.template.metadata.labels'|
|apps, core|Deployment, ServiceAccount|violation: Check if a Deployment has 'spec.serviceAccountName' set, there is a matching v1:ServiceAccount|
|core, networking.k8s.io|Namespace, NetworkPolicy|violation: Check if a Namespace has a networking.k8s.io/v1:NetworkPolicy|
|core, monitoring.coreos.com|Service, ServiceMonitor|violation: Check if a Service has a matching monitoring.coreos.com/v1:ServiceMonitor, via 'spec.selector'|
|apps.openshift.io, apps, core, route.openshift.io|DeploymentConfig, DaemonSet, Deployment, StatefulSet, Service, Route|violation: Check if all workload related kinds contain labels as suggested by https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have the CONTAINER_MAX_MEMORY env set using the downward api|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds are not using the latest tag for their image|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds do not set the Java Xmx option|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have consistent key names for their labels|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have not set their probes to be the same|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have their liveness prob set|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have their readiness prob set|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds do not set limits for CPU|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds limits for memory is not greater than an upper bound|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds has set their limits for memory|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds memory limits and requests unit is valid|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds cpu requests unit is valid|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds requests for memory is not greater than an upper bound|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds do not have secrets mounted as envs|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds have consistent paths for their volume mounts|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds does not specify a volume without a corresponding volume mount|
|apps.openshift.io|DeploymentConfig|violation: Check if a DeploymentConfig has 'spec.triggers' set|
|apps.openshift.io, apps|DeploymentConfig, DaemonSet, Deployment, StatefulSet|violation: Check workload kinds has 'spec.hostNetwork' set|
|apps.openshift.io, apps|DeploymentConfig, Deployment|violation: Check workload kinds has replicas <= 1|
|apps.openshift.io, apps|DeploymentConfig, Deployment|violation: Check workload kinds has replicas not odd|
|rbac.authorization.k8s.io|RoleBinding|violation: Check if a RoleBinding has 'roleRef.apiGroup' set|
|rbac.authorization.k8s.io|RoleBinding|violation: Check if a RoleBinding has 'roleRef.kind' set|
|v1|BuildConfig|violation: Check for deprecated v1 apiVersion. OCP4.x expects build.openshift.io/v1|
|v1|DeploymentConfig|violation: Check for deprecated v1 apiVersion. OCP4.x expects apps.openshift.io/v1|
|v1|ImageStream|violation: Check for deprecated v1 apiVersion. OCP4.x expects image.openshift.io/v1|
|v1|ProjectRequest|violation: Check for deprecated v1 apiVersion. OCP4.x expects project.openshift.io/v1|
|v1|RoleBinding|violation: Check for deprecated v1 apiVersion. OCP4.x expects rbac.authorization.k8s.io/v1|
|v1|Route|violation: Check for deprecated v1 apiVersion. OCP4.x expects route.openshift.io/v1|
|v1|SecurityContextConstraints|violation: Check for deprecated v1 apiVersion. OCP4.x expects security.openshift.io/v1|
|v1|Template|violation: Check for deprecated v1 apiVersion. OCP4.x expects template.openshift.io/v1|
|build.openshift.io|BuildConfig|violation: Check if 'exposeDockerSocket' is set on a BuildConfig. See: https://docs.openshift.com/container-platform/4.1/release_notes/ocp-4-1-release-notes.html#ocp-41-deprecated-features|
|authorization.openshift.io|ClusterRole, ClusterRoleBinding, Role, RoleBinding|violation: Check for deprecated authorization.openshift.io apiVersion. >= OCP4.2 expects rbac.authorization.k8s.io/v1. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|automationbroker.io|Bundle, BundleBinding, BundleInstance|violation: Check for deprecated automationbroker.io/v1alpha1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|operators.coreos.com|CatalogSourceConfigs|violation: Check for deprecated operators.coreos.com/v1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|operators.coreos.com|CatalogSourceConfigs|violation: Check for deprecated operators.coreos.com/v2 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|operators.coreos.com|OperatorSource|violation: Check for deprecated operators.coreos.com/v1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|osb.openshift.io|TemplateServiceBroker, AutomationBroker|violation: Check for deprecated osb.openshift.io/v1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|servicecatalog.k8s.io|ClusterServiceBroker, ClusterServiceClass, ClusterServicePlan, ServiceInstance, ServiceBinding|violation: Check for deprecated servicecatalog.k8s.io/v1beta1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features|
|build.openshift.io|BuildConfig|violation: Check if 'jenkinsPipelineStrategy' is set on a BuildConfig. See: https://docs.openshift.com/container-platform/4.3/release_notes/ocp-4-3-release-notes.html#ocp-4-3-deprecated-features|
|redhat-cop.github.com|PodmanHistory|violation: Check the image contains a specific SHA in its history|
|redhat-cop.github.com|PodmanImages|violation: Check the image size is not greater than a specific value|
