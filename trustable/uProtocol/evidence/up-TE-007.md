---
active: true
derived: false
doc:
  name: uProtocol Trustable Evidence (up-TE)
  ref: up-TE
  title: uProtocol Trustable Evidence
level: 1.7
links:
- up-TA-002: PXBDYoA8o-ZW8ZXLUUBuYNRZdzb0ZxUJxdqDtPKbvSE=
normative: true
ref: ''
reviewed: qfkxWPuJU9Jz_Z0-V5Cho0dA7WtwTqiOQmpr99o5TjM=
---

up-rust automatically (each build) verifies that licenses of dependencies conform to project requirements:

- [cargo deny configuration](/up-rust/deny.toml)
- [cargo deny in build workflow](/up-rust/.github/workflows/check.yaml)
- [Eclipse dash took license check workflow](/up-rust/.github/workflows/check-dependencies.yaml)
