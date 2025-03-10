---
active: true
derived: false
level: 1.13.1
links: []
normative: false
ref: ''
reviewed: FmoKHlg4w-YD2AH6QO72aOd1kw0tlXNDD_eKMq4KI7A=
---

**Guidance**

This assertion is satisfied to the extent that test data, and data collected
from monitoring of deployed versions of uProtocol, has been analysed, and the results
used to inform the refinement of expectations and risk analysis.

The extent of the analysis is with sufficient precision to confirm that:

- all expectations (TA-A_08) are met
- all misbehaviours (TA-A_09) are detected or mitigated
- all advance warning indicators (TA-A_10) are monitored
- misbehaviour/failure rates (calculated directly or inferred by statistics) are
  within acceptable tolerance

Where test results expose misbehaviours not identified in our analysis (TA-A_13),
we add the new misbehaviours to our Expectations (TA-A_08 and TA-A_09). Where
necessary, as informed by our ongoing confidence evaluation (TA-A_15), we improve
and repeat the analysis (TA-A_13).

**Evidence**

- Analysis of test data vs thresholds
- Analysis of failures
- Analysis of spikes and trends

**Confidence scoring**

CS-A_13 is based on Key Performance Indicators (KPIs) that may indicate
problems in development, test, or production

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
