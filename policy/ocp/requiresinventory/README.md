# ocp/requiresinventory
These policies can only be executed via `Gatekeeper` as they require `data.inventory`.
`conftest` can be used if `--data` is passed to provide `data.inventory`.

As `data.inventory` is a cache, these policies create an order of creation dependency. 
For example, a PVC which is created after the Deployment for `deployment-has-matching-pvc` would cause the policy to deny.
Due to this, policies which require `data.inventory` should be limited as it is possible to create unforeseen issues.