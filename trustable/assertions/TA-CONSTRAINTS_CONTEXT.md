---
level: 1.11.1
normative: false
---

**Guidance**

Constraints on reuse, reconfiguration, modification, and deployment are specified to enhance the trustability of outputs. To ensure clarity, scoping boundaries regarding what the output cannot do - especially where common assumptions from applied domains may not hold - must be explicitly documented. These constraints are distinct from measures that mitigate misbehaviours; rather, they define the boundaries within which the system is designed to operate. This upfront documentation  clarifies the intended use of specified Statements, highlights known limitations, and prevents misinterpretation.

These constraints - categorized into explicit limitations and assumptions of use - serve as a guide for both stakeholders and users. They define the intended
scope and provide a clear interface for how upstream and downstream systems can integrate, modify, install, reuse, or reconfigure to achieve the desired output.
Additionally, the documentation explicitly defines the contexts in which the integrity of existing Statements is preserved and whether any reimplementation is necessary.

Crucially, these limitations are not unresolved defects resulting from triage decisions but deliberate exclusions based on design choices. Each omission should be accompanied by a clear rationale, ensuring transparency for future scope expansion and guiding both upstream and downstream modifications.

**Suggested evidence**

- Installation manuals with worked examples
- Configuration manuals with worked examples
- Specification documentation with a clearly defined scope
- User guides detailing limitations in interfaces designed for expandability or modularity
- Documented strategies used by external users to address constraints and work with existing Statements

**Confidence scoring**

The reliability of these constraints should be assessed based on the absence of contradictions and obvious pitfalls within the defined Statements.

**Checklist**

- Are the constraints grounded in realistic expectations, backed by real-world examples?
- Do they effectively guide downstreams in expanding upon existing Statements?
- Do they provide clear guidance for upstreams on reusing components with well-defined claims?
- Are any Statements explicitly designated as not reusable or adaptable?
- Are there worked examples from downstream or upstream users demonstrating these constraints in practice?
- Have there been any documented misunderstandings from users, and are these visibly resolved?
- Do external users actively keep up with updates, and are they properly notified of any changes?
