# @title RHCOP-OCP_BESTPRACT-00027: DeploymentConfig triggers container name miss match
#
# If you are using a DeploymentConfig with 'spec.triggers' set, but the container name does not match the trigger will never fire.
# There is probably a mistake in your definition.
#
# @kinds apps.openshift.io/DeploymentConfig
package ocp.bestpractices.deploymentconfig_triggers_containername

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00027")
  openshift.is_deploymentconfig

  triggerImageChangeParams := konstraint_core.resource.spec.triggers[_].imageChangeParams
  triggerContainerName := triggerImageChangeParams.containerNames[_]

  not containers_contains_trigger(openshift.containers, triggerContainerName)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has a imageChangeParams trigger with a miss-matching container name for '%s'", [konstraint_core.kind, konstraint_core.name, triggerContainerName]), "RHCOP-OCP_BESTPRACT-00027")
}

containers_contains_trigger(containers, triggerContainerName) {
  containers[_].name == triggerContainerName
}