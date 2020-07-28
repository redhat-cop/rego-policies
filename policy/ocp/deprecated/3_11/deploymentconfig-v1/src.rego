package ocp.deprecated.ocp3_11.deploymentconfig_v1

import data.lib.konstraint

# @title DeploymentConfig no longer served by v1
#
# OCP4.x expects apps.openshift.io/v1.
#
# @kinds v1/DeploymentConfig
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "deploymentconfig"

  msg := konstraint.format(sprintf("%s/%s: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead.", [obj.kind, obj.metadata.name]))
}