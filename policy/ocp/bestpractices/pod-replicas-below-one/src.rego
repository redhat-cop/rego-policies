# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00021: Pod replica below 1'
# description: |-
#   Never run a single Pod individually.
#   See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - Deployment
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
package ocp.bestpractices.pod_replicas_below_one

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00021")
	openshift.pod

	replicas := konstraint_core.resource.spec.replicas
	replicas <= 1

	msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected replicas to be greater than 1 for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00021")
}
