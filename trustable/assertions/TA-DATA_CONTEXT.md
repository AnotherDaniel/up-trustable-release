---
active: true
derived: false
level: 1.13.1
links: []
normative: false
ref: ''
reviewed: j9stHNgDESo6c0moOQNZju3TJmY0lf2aCRJcFuiLU0s=
---

**Guidance**

This assertion is satisfied if results from all tests and monitored deployments are captured accurately, ensuring:

- Sufficient precision for meaningful analysis
- Enough contextual information to reproduce the test setup, though not necessarily the exact results (e.g., runner ID, software version SHA)

To prevent misinterpretation, all data storage mechanisms and locations must be documented, along with long-term storage strategies, ensuring historical analyses can be reliably replicated.

**Evidence**

- Time-series results for each test.
- List of monitored indicators.
- Time-series test data for each indicator.
- Time-series production data for each indicator.

**Confidence scoring**

Confidence scoring for TA-DATA is based on comparison of actual failure
rates with targets, and analysis of spikes and trends

**Checklist**

- Is all test data stored with long-term accessibility?
- Is all monitoring data stored with long-term accessibility?
- Are extensible data models implemented?
- Is sensitive data handled correctly (broadcasted, stored, discarded, or anonymised) with appropriate encryption and redundancy?
- Are proper backup mechanisms in place?
- Are storage and backup limits tested?
- Are all data changes traceable?
- Are concurrent changes correctly managed and resolved?
- Is data accessible only to intended parties?
- Are any subsets of our data being published?
