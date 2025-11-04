# Eclipse Process <-> TSF

## Derived Statements

- *Description*: License compliance validation of releases adherence to Eclipse-mandated obligations
  - *TSF*: TA-INPUTS
  - *Eclipse Development Process*: "6.4 Releases"
  - *Evidence*: License compliance tool results
  - *Evidence*: Third-party license obligation fulfillment documentation

- *Description*: Eclipse project are encouraged to generate Software Bill of Materials (SBOMs) for the software that they produce
  - *TSF*: TA-INPUTS
  - *Eclipse Handbook*: "Software Bill of Materials"
  - *Evidence*: SBOM information e.g. as part of releases

- *Description*: All Eclipse project source code is kept and made publicly accessibly via Eclipse-managed infrastructure
  - *TSF*: TA-RELEASES
  - *Eclipse Handbook*: "Project Resources and Services", "External Resources"
  - *Evidence*: Source code repo is part of Eclipse-managed organization

- *Description*: Each release of an Eclipse project undergoes formal review and approval
  - *TSF*: TA-RELEASES
  - *Eclipse Handbook*: "Project Releases and Reviews" "Releases"
  - *Evidence*: Release review documentation on eclipse.org
  - *Evidence*: PMC approval votes for releases, e.g. documented on level of release PR / MR (to be documented in the repository in some form)

- *Description*: Technical metadata of an Eclipse project is always correct and up to date
  - *TSF*: TA-RELEASES, TA-TESTS
  - *Eclipse Handbook*: "Project Resources and Services"
  - *Evidence*: Project repository, including e.g. Cargo.toml, jar index files, etc
  - *Evidence*: Project CI in some form checking/using/validating metadata

- *Description*: Build instructions for Eclipse projects are documented and publicly accessible, easily reproducible by anyone
  - *TSF*: TA-RELEASES, TA-TESTS
  - *Eclipse Handbook*: "Project Resources and Services" "Builds"
  - *Eclipse Handbook*: "Legal documentation requirements" "Contributor Guide"
  - *Evidence*: README.md or CONTRIBUTING.md files in project repositories
  - *Evidence*: Developer documentation on project websites

- *Description*: Contribution process for an Eclipse project is documented and followed
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Legal Documentation Requirements" "Contributor Guide"
  - *Evidence*: File CONTRIBUTING.md or relevant information in README.md exists
  - *Evidence*: Guidelines are being followed in PRs

- *Description*: All Eclipse project tickets, issue discussions, bug reports and decisions are kept and made publicly accessibly via Eclipse-managed infrastructure
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: ""Project Resources and Services", "External Resources"
  - *Eclipse Foundation Development Process*: "Principles", "Open Rules of Engagement" (Section 2.1)
  - *Evidence*: Project repository, related infrastructure like discussion boards and issue trackers

- *Description*: All Eclipse project tickets, issue discussions, bug reports and decisions are done in a healthy manner, are addressed, are actually resolved etc...
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*:
  - *Eclipse Foundation Development Process*: 
  - *Evidence*: Project repository, related infrastructure like discussion boards and issue trackers

- *Description*: All changes to Eclipse projects are tracked through version control with full attribution
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Project Resources and Services"
  - *Evidence*: Git commit history with author attribution
  - *Evidence*: Pull/merge request records with review history

- *Description*: Changes to Eclipse projects are encouraged to go through review, and only merged on approval
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Project Resources and Services"
  - *Evidence*: Git commit history with author attribution
  - *Evidence*: Pull/merge request records with review history

- *Description*: Eclipse project commit records have a consistent form, include author and should reference an issue that they are addressing
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Project Resources and Services" "Git Commit Records"
  - *Eclipse Handbook*: "Community" "Issues"
  - *Evidence*: Commit Records?

- *Description*: Eclipse projects should contain information about how and where to report security issues
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Legal documentation requirements" "SECURITY File"
  - *Evidence*: SECURITY.md file exists

- *Description*: All Eclipse projects follow obligations and practices regarding the analysis and reporting and disclosure of vulnerabilities
  - *TSF*: TA-FIXES
  - *Eclipse Handbook*: "Managing and Reporting Vulnerabilities"
  - *Evidence*: Records of analysis, fix and disclosure activies for reported vulnerabilities

- *Description*: Eclipse project scope and objectives are formally documented and maintained
  - *TSF*: TA-BEHAVIOURS
  - *Eclipse Handbook*: "Starting an Open Source Project at the Eclipse Foundation", "Project Proposal"
  - *Eclipse Handbook*: "Project Management Infrastructure (PMI)", "Project Metadata"
  - *Eclipse Foundation Development Process*: "Scope" (Section 4.5)
  - *Evidence*: Project charter documents on eclipse.org

- *Description*: Eclipse projects must have a README file with information about the project
  - *TSF*: TA-BEHAVIOURS
  - *Eclipse Handbook*: "Incubation", "Development", "Provide legal documentation"
  - *Evidence*: Project repository

- *Description*: All Eclipse projects follow the Eclipse Foundation Development Process
  - *TSF*: TA-METHODOLOGIES
  - *Eclipse Development Process*: "3 Requirements"
  - *Evidence*: Eclipse Development Process compliance documentation
  - *Evidence*: Project lifecycle milestone completion records <- Check this, where are they, what are they?

---

## Missing TSF Tenets - should this be a thing?

- *Description*: All project communication happens in public and transparently
  - *TSF*: TA-TRANSPARENCY
  - *Eclipse Handbook*: "Project Resources and Services" "Open, Transparent and Meritocratic"

- *Description*: Project repositories are the exlusive source of all content related to the project.
  - *TSF*: TA-TRANSPARENCY
  - *Eclipse Handbook*: "Project Resources and Services" "Source Code Management"

## Missing TSF Tenets - all things IP

- *Description*: All project source code origins are tracked through initial contribution records
  - TSF: MISSING TA-AUTHORSHIP
  - *Eclipse Handbook*: "Initial Contribution"
  - *Evidence*: Initial contribution IP logs in Eclipse Foundation IP database
  - *Evidence*: Git repository commit history showing initial contributions

- *Description*: All contributors are identified through Eclipse Contributor Agreement (ECA) signatures
  - TSF: MISSING TA-AUTHORSHIP
  - *Eclipse Handbook*: "Development"
  - *Evidence*: ECA signature records in Eclipse Foundation systems
  - *Evidence*: Git commit author/committer attribution linked to Eclipse accounts

- *Description*: All committers are vetted and approved through formal nomination process
  - TSF: MISSING TA-AUTHORSHIP, TA-ROLES_QUALIFICATION
  - *Eclipse Handbook*: "Project Roles", "Committers"
  - *Evidence*: Committer election records in project mailing lists
  - *Evidence*: Project Management Committee (PMC) approval documentation

- *Description*: All third-party content undergoes Eclipse Foundation IP review process
  - TSF: MISSING TA-IP_CLEARANCE
  - *Eclipse Handbook*: "Intellectual Property", "Third Party Content"
  - *Evidence*: IP approval records in Eclipse Foundation IP database
  - *Evidence*: ClearlyDefined or similar IP scanning results for dependencies

- *Description*: License compatibility is verified for all project dependencies
  - TSF: MISSING TA-LICENSE_CLEARANCE
  - *Eclipse Handbook*: "Intellectual Property", "License Compatibility"
  - *Evidence*: License review documentation in project IP logs
  - *Evidence*: SPDX files or equivalent license documentation

- *Description*: License compatibility is checked and documented
  - TSF: MISSING TA-LICENSE_COMPLIANCE
  - *Eclipse Handbook*: "Intellectual Property" "License Compatibility"
  - *Evidence*: License compliance documentation and procedures
  - *Evidence*: Third-party license obligation documentation

- *Description*: Every file contains copyright headers
  - TSF: MISSING TA-AUTHORSHIP
  - *Eclipse Handbook*: "Copyright Headers"

- *Description*: Every project must contain metadata on 3rd party licensing and IP ownership
  - TSF: MISSING TA-AUTHORSHIP
  - *Eclipse Handbook*: "Notice Files"

- *Description*: Every project must contain metadata information in case it contains cryptography code
  - TSF: MISSING TA-LEGAL_COMPLIANCE
  - *Eclipse Handbook*: "Notice Files"
