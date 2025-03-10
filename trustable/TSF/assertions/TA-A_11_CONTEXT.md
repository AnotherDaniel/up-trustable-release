---
active: true
derived: false
level: 1.11.1
links: []
normative: false
ref: ''
reviewed: leWqR6W8AhnqSsAzAzpBeNt4zlUV2OeGA6NeQD55vE8=
---

**Guidance**

This assertion is satisfied to the extent that all of the tests specified in
TA-A_08 and constructed in TA-A_04 are correctly executed in a controlled
environment on a defined cadence (e.g. daily) or for each proposed change, and
on all candidate release builds for uProtocol.

Note that correct behaviour of tests may be confirmed using fault induction
(e.g. by introducing an error or misconfiguration into uProtocol).

**Evidence**

- Test results from per-change tests
- Test results from scheduled tests as time series

**Confidence scoring**

CS-A_11 is based on verification that we have results for all tests (both
pass / fail and performance)

**Checklist**

- How confident are we that all test results are being captured?
- Can we look at any individual test result, and establish what it relates to?
- Can we trace from any test result to the expectation it relates to?
- Can we identify precisely which environment (software and hardware) were used?
- How many pass/fail results would be expected, based on the scheduled tests?
- Do we have all of the expected results
- Do we have time-series data for all of those results?
- If there are any gaps, do we understand why?
