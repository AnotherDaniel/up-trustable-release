---
active: true
derived: false
level: 1.1.1
links: []
normative: false
ref: ''
reviewed: 3RNCEu5pfIyiO_CHLSIyRArpqyctrts4BvAq1yrr_Io=
---

**Guidance**

This assertion is satisfied to the extent that we have traced and captured
source code for XYZ and all of its dependencies (including transitive
dependencies, all the way down), and for all of the tools used to construct
XYZ from source, and have mirrored versions of these inputs under our control.

'Mirrored' in this context means that we have a version of the upstream project
that we keep up-to-date with additions and changes to the upstream project,
but which is protected from changes that would delete the project, or remove
parts of its history.

Clearly this is not possible for components or tools are provided only in
binary form, or accessed via online services - in these circumstances we can
only assess confidence based on attestations made by the suppliers, and on our
experience with the suppliers' people and processes.

Keep in mind that even if repositories with source code for a particular
component or tool are available, not all of it may be stored in Git as
plaintext. A deeper analysis is required in TA-INPUTS to assess the impact of any
binaries present within the repositories of the components and tools used.

**Evidence**

- list of all XYZ components including
  - URL of mirrored projects in controlled environment
  - URL of upstream projects
- successful build of XYZ from source
  - without access to external source projects
  - without access to cached data
- update logs for mirrored projects
- mirrors reject history rewrites
- mirroring is configured via infrastructure under direct control

**Confidence scoring**

Confidence scoring for TA-SUPPLY_CHAIN is based on confidence that all inputs and
dependencies are identified and mirrored, and that mirrored projects cannot be
compromised.

**Checklist**

- Could there be other components, missed from the list?
- Does the list include all toolchain components?
- Does the toolchain include a bootstrap?
- Could the content of a mirrored project be compromised by an upstream change?
- Are mirrored projects up to date with the upstream project?
