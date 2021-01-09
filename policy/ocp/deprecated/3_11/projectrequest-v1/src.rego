package ocp.deprecated.ocp3_11.projectrequest_v1

import data.lib.konstraint.core as konstraint_core

# @title ProjectRequest no longer served by v1
#
# OCP4.x expects project.openshift.io/v1.
#
# @kinds v1/ProjectRequest
violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "projectrequest"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}