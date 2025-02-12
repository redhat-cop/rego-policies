# combine
These policies can only be executed via `conftest` and use the `--combine` param. As combine sets the `input` as an array,
only policies that cannot be written using the `Gatekeeper` `data.inventory` cache should be created here.

As the `input` is an array; selectors should be used where possible to match object dependencies.
Due to this, policies which require `--combine` should be limited as it is possible to create unforeseen issues.
