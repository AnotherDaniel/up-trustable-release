---
active: true
derived: false
level: 1.9.1
links: []
normative: false
ref: ''
reviewed: NQvDTtu0ZRPZM9a35TRWSUZHBI4aTOqHQ04ARHmiFs0=
---

**Guidance**

This assertion is satisfied to the extent that we have identified misbehaviours
that can interfere with the Expectations of uProtocol, and can demonstrate what
happens when they occur.

After defining what we expect from uProtocol in TA-A_08, we need to analyse what
could go wrong. This may be achieved by:

* applying risk/hazard analysis techniques (e.g. HAZOP, FMEDA, STPA)
* using testing techniques (soak and stress tests, Fault Induction) to discover
  misbehaviours not identified by analysis
* identifying other misbehaviours via test data analysis (see TA-A_13).

The outputs of risk / hazard analysis should be a set of short sentences
describing prohibited misbehaviours or failure modes of uProtocol, and a set of new or
improved Expectations addressing these misbehaviours.

By comparing the set of misbehaviours with the set of Expectations from
TA-A_08, we can gauge our coverage; typically we would expect at least one
misbehaviour for each Expectation.

We can use Fault Induction to verify that the tests developed to detect these
misbehaviours fail when they occur. We can also use this technique, along with
stress and soak testing, to verify that features of uProtocol intended to prevent or
mitigate misbehaviours perform as expected. Examples of this include:

- adding programming errors and misconfigurations into the target software
- adding workload stresses to starve resources or overload the system
- providing unexpected input combinations (e.g. via fuzzing)

These techniques help us to:

- Demonstrate that tests react correctly to misbehaviours
- Demonstrate that mitigations behave as expected
- Expose misbehaviours that we have not already identified or anticipated, by:
    - simulating adverse system conditions (e.g. stress tests)
    - triggering known component misbehaviours (e.g. exception tests)
- Catch unintended effects in later system changes, including integration of
  software in a new system context

**Evidence**

- List of identified misbehaviours
- List of Expectations addressing identified misbehaviours
- Risk analysis results
- Test analysis results (see TA-A_13)
- List of false negative tests
- List of exception handling tests
- List of stress tests
- List of soak tests
- List of misbehaviours without linked Expectations
- List of misbehaviours without linked tests

**Confidence scoring**

CS-A_09 is based on confidence that identification and coverage of
misbehaviours by tests is complete when considered against the list of
Expectations.

**Checklist**

- How has the list of misbehaviours varied over time?
- How confident can we be that this list is comprehensive?
- How well do the misbehaviours map to the expectations?
- Could some participants have incentives to manipulate information?
- Could there be whole categories of misbehaviours still undiscovered?
- Can we identify misbehaviours that have been understood but not specified?
- Can we identify some new misbehaviours, right now?
- Is every misbehaviour represented by at least one fault induction test?
- Are fault inductions used to demonstrate that tests which usually pass can
  and do fail appropriately?
- Are all the fault induction results actually collected?
- Are the results evaluated?
