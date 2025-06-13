---
level: 1.12.1
normative: false
---

**Guidance**

This assertion is satisfied to the extent that all of the tests specified in TA-BEHAVIOURS and constructed in TA-TESTS are correctly executed in a controlled environment on a defined cadence (e.g. daily) or for each proposed change, and on all candidate release builds for XYZ.

Note that correct behaviour of tests may be confirmed using fault induction (e.g. by introducing an error or misconfiguration into XYZ).

**Evidence**

- Test results from per-change tests
- Test results from scheduled tests as time series

**Confidence scoring**

Confidence scoring for TA-VALIDATION is based on verification that we have results for all tests (both pass / fail and performance)

**Checklist**

- How confident are we that all test results are being captured?
- Can we look at any individual test result, and establish what it relates to?
- Can we trace from any test result to the expectation it relates to?
- Can we identify precisely which environment (software and hardware) were used?
- How many pass/fail results would be expected, based on the scheduled tests?
- Do we have all of the expected results
- Do we have time-series data for all of those results?
- If there are any gaps, do we understand why?
- Are the test validation strategies credible and appropriate?
- What proportion of the implemented tests are validated?
