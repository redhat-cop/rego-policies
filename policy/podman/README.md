# podman
These policies can only be executed via `conftest` and use a wrapped data input format:

```json
{
  "apiVersion": "redhat-cop.github.com/v1",
  "kind": "PodmanCommand",
  "items": [
    {
      "json-output-from": "podman-command"
    }
  ]
}
```