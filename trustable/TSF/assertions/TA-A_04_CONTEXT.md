---
active: true
derived: false
level: 1.4.1
links: []
normative: false
ref: ''
reviewed: cBAbe6SACe4ke95z9XkwptoLZ67hYZIELesDBrtCjdI=
---

**Guidance**

This assertion is satisfied to the extent that we

- have implemented all of the tests specified in TA-A_08
- have implemented fault inductions specified in TA-A_09
- have implemented or integrated test tooling and environments for these
- can demonstrate that all of these are constructed from:
  - change-managed sources (see TA-A_07)
  - mirrored sources (see TA-A_01)

All of the above must ensure that test results are retroactively reproducible,
which is easily achieved through automated end-to-end test execution alongside
necessary environment setups. Note that with non-deterministic software, exact
results may not be reproducible, but high-level takeaways and exact setup should
still be possible.

**Evidence**

- list of tests
- list of fault inductions
- list of test environments
- construction configuration and results

**Confidence scoring**

CS-A_04 is based on the presence of tests and our confidence in their
implementation and construction.

**CHECKLIST**

- How confident are we that we've implemented all of the specified tests?
- How confident are we that we've implemented all of the specified fault
  inductions?
- How confident are we that we have test tooling and environments enabling us
  to execute these tests and fault inductions?
- How confident are we that all test components are taken from within our
  controlled environment?
- How confident are we that all of the test environments we are using are also
  under our control?
