---
active: true
derived: false
level: 1.5.1
links: []
normative: false
ref: ''
reviewed: DawyIRbHNx0eRonLrwjc02he2xDCTjPp2_-bzVACCSw=
---

**Guidance**

This assertion is best satisfied by checking generated documentation to confirm
that:

- all components, dependencies and tools are identified in a manifest
- the manifest includes links to source code
- where source is unavailable, the supplier is identified

**Evidence**

- list of components with source
  - source code
  - build instructions
  - test code
  - test results summary
  - attestations
- list of components where source code is not available
  - risk analysis
  - attestations

**Confidence scoring**

Confidence scoring for TA-ITERATIONS based on

- number and importance of source components
- number and importance of non-source components
- assessment of attestations

**Checklist**

- How much of the software is provided as binary only, expressed as a
  fraction of the BoM list?
- How much is binary, expressed as a fraction of the total storage footprint?
- For binaries, what claims are being made and how confident are we in the
  people/organisations making the claims?
- For third-party source code, what claims are we making, and how confident
  are we about these claims?
- For software developed by us, what claims are we making, and how confident
  are we about these claims?
