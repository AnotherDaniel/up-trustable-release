---
active: true
derived: false
level: 1.10.1
links: []
normative: false
ref: ''
reviewed: JYqHQuo5hbV6XbRh5gDu8iIKFEoSoViBDvsd9Zgn7HA=
---

**Guidance**

To satisfy this assertion we need to find indicators or other observable
properties of misbehaviours, or conditions that can trigger misbehaviours.
Ideally these are _leading indicators_, which can give us advance warning of the
occurrence of misbehaviours, so that preventative measures, mitigations or
safety mechanisms can be applied in time.

Potential warning indicators may be derived by analysis of source code,
by consideration of test results, and by troubleshooting observed faults.

The mechanisms used to collect warning indicator data must themselves be
considered in the Trustable scope of XYZ. Thus they should be covered by new
or improved Expectations, some of which may need to be satisfied by users or
integrators of XYZ.

Note that we can consider coverage here, by counting how many of the identified
misbehaviours we are unable to find indicators for.

We also consider whether or not monitoring is implemented for all of the
indicators, both in test/lab conditions and in production use.

Again we can consider coverage, by counting the indicators that are not
monitored.

**Evidence**

- Risk analyses
- List of advance warning indicators
- List of Expectations for monitoring mechanisms
- List of implemented monitoring mechanisms
- List of identified misbehaviours without advance warning indicators
- List of advance warning indicators without implemented monitoring mechanisms
- Advance warning signal data as time series (see TA-A_12)

**Confidence scoring**

CS-A_10 is based on confidence that the list of indicators is comprehensive /
complete, that the indicators are useful, and that monitoring mechanisms have
been implemented to collect the required data.

**Checklist**

- How appropriate/thorough are the analyses that led to the indicators?
- How confident can we be that the list of indicators is comprehensive?
- Could there be whole categories of warning indicators still missing?
- How has the list of advance warning indicators varied over time?
- How confident are we that the indicators are leading/predictive?
- Are there misbehaviours that have no advance warning indicators?
- Can we collect data for all indicators?
- Are the monitoring mechanisms used included in our Trustable scope?
- Are there gaps or trends in the data?
- If there are gaps or trends, are they analysed and addressed?
- Is the data actually predictive/useful?
