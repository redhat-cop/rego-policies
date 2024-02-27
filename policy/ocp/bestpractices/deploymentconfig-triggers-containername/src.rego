# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00027: DeploymentConfig triggers container name miss match'
# description: |-
#   If you are using a DeploymentConfig with 'spec.triggers' set,
#   but the container name does not match the trigger will never fire. There is probably a mistake in your definition.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
package ocp.bestpractices.deploymentconfig_triggers_containername

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00027")
	openshift.is_deploymentconfig

	some trigger in konstraint_core.resource.spec.triggers
	some container_name in trigger.imageChangeParams.containerNames

	not containers_contains_trigger(openshift.containers, container_name)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: has a imageChangeParams trigger with a miss-matching container name for '%s'", [konstraint_core.kind, konstraint_core.name, container_name]), "RHCOP-OCP_BESTPRACT-00027")
}

# regal ignore:custom-in-construct
containers_contains_trigger(containers, container_name) {
	some container in containers
	container.name == container_name
}
