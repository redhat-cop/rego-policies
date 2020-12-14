package ocp.deprecated.ocp3_11.template_v1

import data.lib.konstraint.core as konstraint_core

# @title Template no longer served by v1
#
# OCP4.x expects template.openshift.io/v1.
#
# @kinds v1/Template
violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "template"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}