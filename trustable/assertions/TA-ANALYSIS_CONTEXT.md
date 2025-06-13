---
level: 1.14.1
normative: false
---

**Guidance**

This assertion is satisfied to the extent that test data, and data collected from monitoring of deployed versions of XYZ, has been analysed, and the results used to inform the refinement of expectations and risk analysis.

The extent of the analysis is with sufficient precision to confirm that:

- all expectations (TA-BEHAVIOURS) are met
- all misbehaviours (TA-MISBEHAVIOURS) are detected or mitigated
- all advance warning indicators (TA-INDICATORS) are monitored
- misbehaviour/failure rates (calculated directly or inferred by statistics) are within acceptable tolerance

Where test results expose misbehaviours not identified in our analysis (TA-ANALYSIS), we add the new misbehaviours to our Expectations (TA-BEHAVIOURS and TA-MISBEHAVIOURS). Where necessary, as informed by our ongoing confidence evaluation (TA-CONFIDENCE), we improve and repeat the analysis (TA-ANALYSIS).

**Evidence**

- Analysis of test data vs thresholds
- Analysis of failures
- Analysis of spikes and trends

**Confidence scoring**

Confidence scoring for TA-ANALYSIS is based on Key Performance Indicators (KPIs) that may indicate problems in development, test, or production

**CHECKLIST**

- What fraction of expectations are covered by the test data?
- What fraction of misbehaviours are covered by the monitored indicator data?
- How confident are we that the indicator data are accurate and timely?
- How reliable is the monitoring process?
- How well does the production data correlate with our test data?
- Are we publishing our data analysis?
- Are we comparing and analysing production data vs test?
- Are our results getting better, or worse?
- Are we addressing spikes/regressions?
- Do we have sensible/appropriate target failure rates?
- Do we need to check the targets?
- Are we achieving the targets?
