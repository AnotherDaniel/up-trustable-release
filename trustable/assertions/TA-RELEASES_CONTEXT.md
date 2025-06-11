---
active: true
derived: false
level: 1.3.1
links: []
normative: false
ref: ''
reviewed: p6xuOX3oci7_WlmYJ66ncFFKky3dc5TKGicWOmiSj5c=
---

**Guidance**

This assertion is satisfied if the construction of a given iteration of XYZ is
both *repeatable*, demonstrating that all of the required inputs are controlled,
and *reproducible*, demonstrating that the construction toolchain and build
environment(s) are controlled (as described by TA-TESTS).

This assertion can be most effectively satisfied in a Continuous Integration
environment with mirrored projects (see TA-SUPPLY_CHAIN), using build servers that have
no internet access. The aim is to show that all build tools, XYZ components and
dependencies are built from inputs that we control, that rebuilding leads to
precisely the same binary fileset, and that builds can be repeated on any
suitably configured server.

Again this will not be achievable for components/tools provided in binary form,
or accessed via an external service - we must consider our confidence in
attestations made by/for the supply chain.

All non-reproducible elements, such as timestamps or embedded random values from
build metadata, are clearly identified and considered when evaluating
reproducibility.

**Evidence**

- list of reproducible SHAs
- list of non-reproducible elements with:
  - explanation and justification
  - details of what is not reproducible
- evidence of configuration management for build instructions and infrastructure
- evidence of repeatable builds

**Confidence scoring**

Calculate:

R = number of reproducible components (including sources which have no build stage)
N = number of non-reproducible
B = number of binaries
M = number of mirrored
X = number of things not mirrored

Confidence scoring for TA-RELEASES could possibly be calculated as
R / (R + N + B + M / (M + X))

**Checklist**

- How confident are we that all components are taken from within our
  controlled environment?
- How confident are we that all of the tools we are using are also under our
  control?
- Are our builds repeatable on a different server, or in a different context?
- How sure are we that our builds don't access the internet?
- How many of our components are non-reproducible?
- How confident are we that our reproducibility check is correct?
