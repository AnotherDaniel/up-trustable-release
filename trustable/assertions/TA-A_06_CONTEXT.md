---
active: true
derived: false
level: 1.6.1
links: []
normative: false
ref: ''
reviewed: PcYChAW6A1fm4aDXw36_bRXBxIXowQueJ6F5dZXFaDw=
---

**Guidance**

This assertion is satisfied to the extent that we have identified, triaged
and applied fixes and/or mitigations to the faults identified in uProtocol and the
bugs and CVEs identified by upstream component projects.

We can increase confidence by assessing known faults, bugs and vulnerabilities,
to establish their relevance and impact for uProtocol.

In principle this should involve not just the code in uProtocol, but also its
dependencies (all the way down), and the tools used to construct the release.
However we need to weigh the cost/benefit of this work, taking into account

- the volume and quality of available bug and CVE reports
- likelihood that our build/configuration/usecase is actually affected

**Evidence**

- List of known bugs fixed since last release
- List of outstanding bugs still not fixed, with triage/prioritisation based
  on severity/relevance/impact
- List of known CVEs fixed since last release
- List of outstanding CVEs still not fixed, with triage/prioritisation based
  on severity/relevance/impact
- List of uProtocol component versions, showing where a newer version exists upstream
- List of component version updates since last release
- List of fixes applied to developed code since last release
- List of fixes for developed code that are outstanding, not applied yet
- List of uProtocol faults outstanding (O)
- List of uProtocol faults fixed since last release (F)
- List of uProtocol faults mitigated since last release (M)

**Confidence scoring**

CS-A_06 can be based on

- some function of [O, F, M] for uProtocol
- number of outstanding relevant bugs from components
- bug triage results, accounting for undiscovered bugs
- number of outstanding CVEs
- CVE triage results, accounting for undiscovered bugs CVEs
- confidence that known fixes have been applied
- confidence that known mitigations have been applied
- previous value of CS-A_06

Each iteration, we should improve the algorithm based on measurements

**Checklist**

- How many faults have we identified in uProtocol?
- How many unknown faults remain to be found, based on the number that have
  been processed so far?
- Is there any possibility that people could be motivated to manipulate the
  lists (e.g. bug bonus or pressure to close).
- How many faults may be unrecorded (or incorrectly closed, or downplayed)?
- How do we collect lists of bugs and CVEs from components?
- How (and how often) do we check these lists for relevant bugs and CVEs?
- How confident can we be that the lists are honestly maintained?
- Could some participants have incentives to manipulate information?
- How confident are we that the lists are comprehensive?
- Could there be whole categories of bugs/CVEs still undiscovered?
- How effective is our triage/prioritisation?
- How many components have never been updated?
- How confident are we that we could update them?
- How confident are we that outstanding fixes do not impact our expectations?
- How confident are we that outstanding fixes do not address misbehaviours?
