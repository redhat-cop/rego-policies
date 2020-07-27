package ocp.deprecated.ocp3_11.template_v1

import data.lib.konstraint

# violation: Check for deprecated v1 apiVersion. OCP4.x expects template.openshift.io/v1
# @kinds v1/Template
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "template"

  msg := konstraint.format(sprintf("%s/%s: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead.", [obj.kind, obj.metadata.name]))
}