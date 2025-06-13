---
level: 1.8.1
normative: false
---

Although it is practically impossible to specify all of the necessary behaviours and required properties for complex software, we must clearly specify the most
important of these (e.g. where harm could result if given criteria are not met), and verify that these are correctly provided by XYZ.

**Guidance**

This assertion is satisfied to the extent that we have:

- Determined which Behaviours are critical for consumers of XYZ and recorded them as Expectations.
- Verified these Behaviours are achieved.

Expectations could be verified by:

- Functional testing for the system.
- Functional soak testing for the system.
- Specifying architecture and verifying its implementation with pre-merge integration testing for components.
- Specifying components and verifying their implementation using pre-merge unit testing.

The number and combination of the above verification strategies will depend on the scale of the project. For example, unit testing is more suitable for the development of a small library than of an OS.

**Evidence**

- List of expectations

**Confidence scoring**

Confidence scoring for TA-BEHAVIOURS is based on our confidence that the list of Expectations is accurate and complete, that Expectations are verified by tests, and that the effectiveness of these tests is validated by appropriate strategies.

**Checklist**

- How has the list of expectations varied over time?
- How confident can we be that this list is comprehensive?
- Could some participants have incentives to manipulate information?
- Could there be whole categories of expectations still undiscovered?
- Can we identify expectations that have been understood but not specified?
- Can we identify some new expectations, right now?
- How confident can we be that this list covers all critical requirements?
- How comprehensive is the list of tests?
- Is every Expectation covered by at least one implemented test?
- Are there any Expectations where we believe more coverage would help?
