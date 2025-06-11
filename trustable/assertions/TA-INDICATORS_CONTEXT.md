---
active: true
derived: false
level: 1.10.1
links: []
normative: false
ref: ''
reviewed: wJkI9yYjZsN5jaPvDMIKJSD96jTVW3CT4nnQ2dnHArg=
---

Not all deviations from Expected Behaviour can be associated with a specific
condition. Therefore, we must have a strategy for managing deviations that
arise from unknown system states, process vulnerabilities or configurations.

This is the role of _Advanced Warning Indicators (AWI)_. These are specific
metrics which correlate with deviations from Expected Behaviour and can be
monitored in real time. The system should return to a defined known-good
state when AWIs exceed defined tolerances.

**Guidance**

This assertion is met to the extent that:

- We have identified indicators that are strongly correlated with observed
  deviations from Expected Behaviour in testing and/or production.
- The system returns to a defined known-good state when AWIs exceed
  defined tolerances.
- The mechanism for returning to the known-good state is verified.
- The selection of Advance Warning Indicators is validated against the set of
  possible deviations from Expected behaviour.

Note, the set of possible deviations from Expected behaviour _is not_ the same
as the set of Misbehaviours identified in TA-MISBEHAVIOURS, as it includes
deviations due to unknown causes.

Deviations are easily determined by negating recorded Expectations. Potential
AWIs could be identified using source code analysis, risk analysis or incident
reports. A set of AWIs to be used in production should be identified by
monitoring candidate signals in all tests (functional, soak, stress) and
measuring correlation with deviations.

The known-good state should be chosen with regard to the system's intended
consumers and/or context. Canonical examples are mechanisms like reboots,
resets, relaunches and restarts. The mechanism for returning to a known-good
state can be verified using fault induction tests. Incidences of AWIs triggering
a return to the known-good state in either testing or production should be
considered as a Misbehaviour in TA-MISBEHAVIOURS. Relying on AWIs alone is not
an acceptable mitigation strategy. TA-MISBEHAVIOURS and TA-INDICATORS are
treated separately for this reason.

The selection of AWIs can be validated by analysing failure data. For instance,
a high number of instances of deviations with all AWIs in tolerance implies the
set of AWIs is incorrect, or the tolerance is too lax.

**Evidence**

- Risk analyses
- List of advance warning indicators
- List of Expectations for monitoring mechanisms
- List of implemented monitoring mechanisms
- List of identified misbehaviours without advance warning indicators
- List of advance warning indicators without implemented monitoring mechanisms
- Advance warning signal data as time series (see TA-DATA)

**Confidence scoring**

Confidence scoring for TA-INDICATORS is based on confidence that the list of
indicators is comprehensive / complete, that the indicators are useful, and that
monitoring mechanisms have been implemented to collect the required data.

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
