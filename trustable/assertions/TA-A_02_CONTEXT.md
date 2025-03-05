---
active: true
derived: false
level: 1.2.1
links: []
normative: false
ref: ''
reviewed: EkM2gd7XGaQfRfCvnIs-CmnR6IJo9C-rRO_vvu0U4vU=
---

**Guidance**

To satisfy this assertion, the components and tools used to construct and verify
XYZ releases need to be identified and assessed, to identify available sources
of evidence about these dependencies.

For components, we need to consider how their potential misbehaviours might
impact our expectations for XYZ, identify sources of information (e.g. bug
databases, published CVEs) that can be used to identify know risks or issues,
and tests that can be used to identify these. These provide the inputs to
TA-A_06.

For the tools we use to construct and verify XYZ, we need to consider how
their misbehaviour might lead to an unintended change in XYZ, or fail to detect
misbehaviours of XYZ during testing, or produce incorrect or incomplete data
that we use when verifying an XYZ release.

Where impacts are identified, we need to consider both how serious they might be
(severity) and whether they would be detected by another tool, test or manual
check (detectability).

For impacts with a high severity and/or low detectability, additional analysis
should be done to check whether existing tests are effective at detecting the
misbehaviours or resulting impacts, and new tests or Expectations should be added
to prevent or detect misbehaviours or impacts that are not currently addressed.

**Evidence**

- List of components used in construction of XYZ including
    - Indication of whether content is provided as source or binary
- Record of component assessment:
    - Originating project and version
    - Date of assessments and identity of assessors
    - Role of component in XYZ
    - Sources of bug and risk data for the component
    - Potential misbehaviours and risks identified and assessed
- List of tools used in construction and verification
- Record of tool impact assessments:
    - Originating project and version of tool
    - Date of assessments and identity of assessors
    - Roles of tool in production of XYZ releases
    - Potential tool misbehaviours and impacts
    - Detectability and severity of impacts
- Record of tool qualification reviews
    - For high impact tools only (low detectability and/or high severity)
    - Link to impact assessment
    - Date of reviews and identity of reviewers
    - Analysis of impacts and misbehaviours
    - Existing tests or measures (e.g. manual reviews) to address these
    - Additional tests and/or Expectations required

**Confidence scoring**

CS-A_02 is based on the set of components and tools identified, how many of
(and how often) these have been assessed for their risk and impact for XYZ, and
the sources of risk and issue data identified.

**Checklist**

- Are there components that are not on the list?
- Are there assessments for all components?
- Has an assessment been done for the current version of the component?
- Have sources of bug and/or vulnerability data been identified?
- Have additional tests and/or Expectations been documented and linked to
  component assessment?
- Are component tests run when integrating new versions of components?
- Are there tools that are not on the list?
- Are there impact assessments for all tools?
- Have tools with high impact been qualified?
- Were assessments or reviews done for the current tool versions?
- Have additional tests and/or Expectations been documented and linked to
  tool assessments?
- Are tool tests run when integrating new versions of tools?
- Are tool and component tests included in release preparation?
- Can patches be applied, and then upstreamed for long-term maintenance?
