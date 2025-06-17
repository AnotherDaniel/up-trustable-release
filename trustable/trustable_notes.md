# Trustable notes for uProtocol (Rust components)

> NOTE: Eventually this file will go away when we have "proper" Trustable 'paperwork'

## Goal

The goal of the work around Trustable and the uProtocol project is to leave consumers of uProtocol (Rust components) with a mechanism of evaluating the level of trust they can and should place in uProtocol while not overburdening the project with processes and rules which would stifle more traditional FOSS methodologies.

Since uProtocol alone is insufficient to construct a safe, or indeed a Trustable, system, we place plenty of expectations on the integrator of this project. These will be detailed such that a consumer of uProtocol knows what extra constraints to place on their work.

## General Note

In any TSF related documents of text snippets, the letters `XYZ` are meant to denote the project TSF is being applied to; to avoid unnecessary changes to this upstream content, we've left the `XYZ` placeholders in place, and ask the reader/reviewer to mentally replace them with `uProtocol (Rust components)`.

This project by its nature is working off and with the [`Trustable Software Framework` (TSF)](https://gitlab.com/CodethinkLabs/trustable/trustable). Specifically we are using the tools provided by that project and we are referencing and currenty copy-including the Trustable Tenets and Assertions published by that project, which is licensed under `CC-BY-SA-4.0`. Any contents included in this repository that is taken from TSF is made available under that same license (`CC-BY-SA-4.0`).

## Approach

Until and unless Trustable release the tooling necessary to present structured materials in a way which is consumable by open-source downstreams of uProtocol, we shall document our Trustability via this text file. Once the above is resolved we will use whatever content formats are appropriate to enable automated validation of trustability.

---

## Tenets - The high level

Trustability is, in some sense, about the aggregation of evidence to support an aggregation of assertions, which chain upwards to an assertion of trustability. The
[Trustable project](https://gitlab.com/CodethinkLabs/trustable/trustable/) defines a number of such assertions as the start of the process, and to guide projects into a well defined approach - these are the Trustable Tenets.

We shall address each Tenet in turn, and for each, we will begin to list out what will be necessary in order that we can start to make assertions of our own.

### Tenet - Provenance

> All source code (and attestations for claims) for uProtocol (Rust components) are provided with known provenance.

In order to meet this, we shall have to ensure that we document all our issues, link merge requests to those issues, and store tests and test results for releases, such that they can be identified and replicated.

The use of GitHub, Gitlab, etc. can provide much of this.

### Tenet - Construction

> Tools are provided to build uProtocol (Rust components) from trusted sources (also provided) with full reproducibility.

Meeting this directly ourselves will be difficult as we will be acting as a traditional FOSS project, using container based builds in our CI pipeline which consume operating systems not necessarily meeting these requirements. We will have to consider at least locking down the SHAs of the containers used to build releases, though making any kind of guarantee about the reproducibility of such containers will be near-impossible.

On the other hand, the full transitive set of dependencies (Rust crates) that comprise our build is pulled from crates.ui with pinned versions, so can be replicated on that level. In addition, it might become relevant to archive all sourced used during build (ie. the contents of the component's `./target` folder) alongside a release, so that this exact same set of code is available for later reproduction.

Some amount of expectation that our consumers deal with this aspect is likely to be required.

### Tenet - Changes

> uProtocol Rust components are actively maintained, with regular updates to dependencies, and changes are verified to prevent regressions.

In part this will come from the continued handling of issues and functionality requests, and subsequent releases of the uProtocol project. In terms of verification of changes to prevent regressions, our evidence there will be via the various test suites and CI jobs we have at hand, and some expectation that our consumers will be running verifications of the outcome of integrating uProtocol into their projects.

### Tenet - Expectations

> Documentation is provided, specifying what uProtocol is expected to do, and what it must not do, and how this is verified.

This will be in part specification on the uProtocol side about functionality and behaviour of the software, along with the CI testing mentioned above, but also will be partly expectations on our consumers with respect to how to verify that the integrated uProtocol Rust components are behaving as needed within their system.

### Tenet - Results

> Evidence is provided to demonstrate that uProtocol Rust components do what they are supposed to do, and do not do what they must not do.

This part of the process will require that we _record_ our testing outcomes somehow in a way that can be verified as part of the trustable methodologies. It may be sufficient to have suitable pipeline results stored in GitHub, it may be necessary that releases contain test summaries indicating outcomes, it may simply be that we place expectations on our consumers that they integrate and run uProtocol's validations as part of their handling of Trustable.

### Tenet - Confidence

> Confidence in uProtocol (Rust components) is measured by analysing actual performance in tests and in production.

This is, quite likely, the only tenet where realistically all we can do is provide guidance on how to do this in an integrating system. uProtocol is not stand-alone and cannot be validated/analysed in any meaningful way when not integrated into a whole. The guidance we therefore provide for this may need to be partially in the form of validation suite(s) which can be run in an integrated system, or at least guidance on what to place in such a suite.

## Assertions - the mid-level

Trustable provides a series of assertions to support the tenets. Each of these will need treatment, however for now we may not be able to, or may have to defer it to our integrators.

### TA-SUPPLY_CHAIN

> All sources for uProtocol (Rust components) and tools are mirrored in our controlled environment

This is not something that uProtocol itself is responsible for - instead we ensure that we document everything necessary for an integrating system to meet this assertion, such as documenting our expectations on the build environment and locking our dependencies via Cargo.lock et al.
Should we want to turn up the compliance level for this assertion, archiving the `target/` folders of our component builds should go some way towwards meeting this demand, as that will provide a mirror of all the dependency sources that were used for the build. Better approaches might exist, and can be iterated towards over time.

### TA-INPUTS

> Components and tools used to construct and verify uProtocol Rust components are assessed, to identify potential risks and issues

This is not explicitly within the current remit of uProtocol as an open source project. However, where the Rust components of the project are concerned, there exist options for sourcing ASIL certified compilers, which are functionally (code-level) identical to the regular upstream copmilers used by uProtocol. So a switch to a certified tool version might be an option for an integrator to help support this statement.

### TA-RELEASES

> Construction of uProtocol (Rust components) releases is fully repeatable and the results are fully reproducible, with any exceptions documented and justified.

Again, this is something where we can provide assistance and documentation, but we cannot actually provide evidence for directly as we are not in control of our integrating systems. Should we want to turn up the compliance level for this assertion, archiving the `target/` folders of our component builds should go some way towwards meeting this demand, as that will provide a mirror of all the dependency sources that were used for the build. Better approaches might exist, and can be iterated towards over time.

### TA-TESTS

> All tests for uProtocol (Rust components), and its build and test environments, are constructed from controlled/mirrored sources and are reproducible, with any exceptions documented

Control is plausible to some extent, however for normal FOSS methodologies (for example, test build pipelines that run on system images provided by GitHub infrastructure) this will not really be possible - As such we will instead aim to provide full documentation of the expectations we place on an integrator to meet this instead; ensuring that nothing we do in our processes would preclude the meeting of this assertion for such downstreams.

### TA-ITERATIONS

> All constructed iterations of uProtocol (Rust components) include source code, build instructions, tests, results and attestations.

For uProtocol, this is best addresed by a fully automated release-build process, which performs all and any test and documentation building steps, and includes the results with the release artifacts.

### TA-FIXES

> Known bugs or misbehaviours are analysed and triaged, and critical fixes or mitigations are implemented or applied.

The evidence which Trustable recommends to support this assertion will generally be artifacts of the release process which we will need to implement; such as detailing the issues dealt with in a release, the issues not yet dealt with, etc.

### TA-UPDATES

> uProtocol Rust components, configurations and tools are updated under specified change and configuration management controls.

This is primarily on an integration project, which needs to show explicit management of used tool and code versions. For the scope of uProtocol (Rust components), all versions of dependencies are explicitly managed by the established Rust mechanisms and are part of the version-controlled repository content. Currently, uProtocol (Rust components) does not explicitly manage the version of the Rust toolchain used in regular builds and relases, instead we use the latest stable version of the toolchain as available in the latest Ubuntu CI images provided within the GitHub infrastructure. This could be changed to using fixed versions at any time when such a change is deemed useful, which it currently isn't.

### TA-BEHAVIOURS

> Expected or required behaviours for uProtocol are identified, specified, verified and validated based on analysis.

Documenting the expected behaviours within our Trustable materials and/or requirements documentation will be necessary here. Every test we run ought to be clear as to _why_ it exists and what it is demonstrating. Where possible, negative assertion tests (ie. checking that things fail when they should) is also appropriate to have. We will endeavour to have a test suite which can be used by the integrating system to subsequently validate behaviour over time.

### TA-MISBEHAVIOURS

> Prohibited misbehaviours for uProtocol (Rust components) are identified, and mitigations are specified, verified and validated based on analysis.

Documentation of expectation here will happen like for TA-BEHAVIOURS, similarly tests where possible should demonstrate that either prohibited behaviours do not occur, or that mitigating actions resolve things when they do. It's likely much of this will, similarly to TA-BEHAVIOURS, require integrating systems to perform validation.

### TA-INDICATORS

> Advance warning indicators for misbehaviours are identified, and monitoring mechanisms are specified, verified and validated based on analysis.

uProtocol is communication infrastructure for a system-of-systems. As such, component-specific advance warning indicators are hard to provide since misbehaviour is likely involving communication between different components and/or systems. There is an onus on uProtocol to have a mechanism of telemetry and fault analysis which supports to understand communication performance and related warning indicators.

### TA-CONSTRAINTS

> Constraints on adaptation and deployment of uProtocol are specified.

Documenting the constraints and assumptions of use of uProtocol within our Trustable materials and/or requirements documentation will be necessary here.

### TA-VALIDATION

> All specified tests are executed repeatedly, under defined conditions in controlled environments, according to specified objectives.

The repeated testing aspect of trusting uProtocol Rust components is two-pronged: We use merge- and release-triggered CI jobs which are used to collect evidence of basic unit and component-level testing by means of running and re-running any test suites which are part of uProtocol directly. However the majority of evidence for this assertion will likely come from the integrating system performing some level of system soak test on a uProtocol service mesh.

### TA-DATA

> Data is collected from tests, and from monitoring of deployed software, according to specified objectives.

Here our use of a forge such as GitHub will assist. We can define our testing objectives purely around success of the suites, and then use the pipeline results as a way to gather evidence that we're meeting the desired outcomes. As for deployed software monitoring, we will need to provide recommendations on how to do this.

### TA-ANALYSIS

> Collected data from tests and monitoring of deployed software is analysed according to specified objectives.

Effectively the same as TA-DATA in terms of what we need to do to get there, and then perhaps some more recommendations for how our integrating systems can analyse outputs.

### TA-METHODOLOGIES

> Manual methodologies applied for uProtocol (Rust components) by contributors, and their results, are managed according to specified objectives.

There are and will be no manual processes involved in building, testing or releasing uProtocol components. Where such manual processes are applied as part of a system integration effort, they will have do be documented and managed in that scope.

### TA-CONFIDENCE

> Confidence in uProtocol (Rust components) is measured based on results of analysis

The uProtocol project does not apply additional or separate analysis methods other than TSF and the tooling that comes with it. As soon as we modify/change score weightings or other methodical aspects of the framework, this needs to be documented appropriately and referenced in this section.
