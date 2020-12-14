package ocp.deprecated.ocp3_11.buildconfig_v1

import data.lib.konstraint.core as konstraint_core

# @title BuildConfig no longer served by v1
#
# OCP4.x expects build.openshift.io/v1.
#
# @kinds v1/BuildConfig
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "buildconfig"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}