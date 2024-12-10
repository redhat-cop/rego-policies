# regal ignore:directory-package-mismatch
package inventory

# Test data to mock out data.inventory cache provided by Gatekeeper
namespace := {"conftest": {"v1": {"FakeKind": {"foobar": {"apiVersion": "v1", "kind": "FakeKind"}}}}}
