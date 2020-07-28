package ocp.deprecated.ocp3_11.projectrequest_v1

import data.lib.konstraint

# @title ProjectRequest no longer served by v1
#
# OCP4.x expects project.openshift.io/v1.
#
# @kinds v1/ProjectRequest
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "projectrequest"

  msg := konstraint.format(sprintf("%s/%s: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead.", [obj.kind, obj.metadata.name]))
}