# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00006: Label key is consistent'
# description: Label keys should be qualified by 'app.kubernetes.io' or 'company.com'
#   to allow a consistent understanding.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod
#       - ReplicationController
#     - apiGroups:
#       - apps
#       kinds:
#       - DaemonSet
#       - Deployment
#       - Job
#       - ReplicaSet
#       - StatefulSet
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
#     - apiGroups:
#       - batch
#       kinds:
#       - CronJob
package ocp.bestpractices.container_labelkey_inconsistent

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00006")
	openshift.pod

	some key

	# regal ignore:prefer-some-in-iteration
	value := konstraint_core.labels[key]

	not label_key_starts_with_expected(key)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found '%s=%s'", [konstraint_core.kind, konstraint_core.name, key, value]), "RHCOP-OCP_BESTPRACT-00006")
}

label_key_starts_with_expected(key) {
	startswith(key, "app.kubernetes.io/")
}

label_key_starts_with_expected(key) {
	startswith(key, "redhat-cop.github.com/")
}
