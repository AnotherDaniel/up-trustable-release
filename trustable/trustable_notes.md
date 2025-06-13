# Trustable notes for uProtocol (Rust components)

> NOTE: Eventually this file will go away when we have "proper" Trustable 'paperwork'

## Goal

The goal of the work around Trustable and the uProtocol project is to leave consumers of uProtocol (Rust components) with a mechanism of evaluating the level of trust they can and should place in uProtocol while not overburdening the project with processes and rules which would stifle more traditional FOSS methodologies.

Since uProtocol alone is insufficient to construct a safe, or indeed a Trustable, system, we place plenty of expectations on the integrator of this project. These will be detailed such that a consumer of uProtocol knows what extra constraints to place on their work.

## General Note

In any TSF related documents of text snippets, the letters `XYZ` are meant to denote the project TSF is being applied to; to avoid unnecessary changes to this upstream content, we've left the `XYZ` placeholders in place, and ask the reader/reviewer to mentally replace them with `uProtocol (Rust components)`.

This project by it's nature is working off and with the [`Trustable Software Framework` (TSF)](https://gitlab.com/CodethinkLabs/trustable/trustable), specifically we are using the tools provided by that project and we are referencing and currenty copy-including the Trustable Tenets and Assertions published by that project, which is licensed under `CC-BY-SA-4.0`. Any contents included in this repository that is taken from TSF is made available under that same license (`CC-BY-SA-4.0`).

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

### TA-1

> Known bugs or misbehaviours are analysed and triaged, and critical fixes or mitigations are implemented or applied.

The evidence which Trustable recommends to support this assertion will generally be artifacts of the release process which we will need to implement; such as detailing the issues dealt with in a release, the issues not yet dealt with, etc.

### TA-2

> Expected or required behaviours for uProtocol are identified, specified, verified and validated based on analysis.

Documenting the expected behaviours within our Trustable materials and/or requirements documentation will be necessary here. Every test we run ought to be clear as to _why_ it exists and what it is demonstrating. Where possible, negative assertion tests (ie. checking that things fail when they should) is also appropriate to have. We will endeavour to have a test suite which can be used by the integrating system to subsequently validate behaviour over time).

### TA-3

> Prohibited misbehaviours for uProtocol (Rust components) are identified, and mitigations are specified, verified and validated based on analysis.

Documentation of expectation here will happen like for TA-2, similarly tests where possible should demonstrate that either prohibited behaviours do not occur, or that mitigating actions resolve things when they do. It's likely much of this will, similarly to TA-2, require integrating systems to perform validation.

### TA-4

> Advance warning indicators for misbehaviours are identified, and monitoring mechanisms are specified, verified and validated based on analysis.

uProtocol is communication infrastructure a system-of-systems. As such, component-specific advance warning indicators are hard to provide since misbehaviour is likely involving communication between different components and/or systems. There is a onus on uProtocol to have a mechanism of telemetry and fault analysis which supports to understand communication performance and related warning indicators.

### TA-5

> All constructed iterations of uProtocol (Rust components) include source code, build instructions, tests, results and attestations.

TODO

### TA-6

> All sources for uProtocol (Rust components) and tools are mirrored in our controlled environment

This is not something that uProtocol itself is responsible for - instead we ensure that we document everything necessary for an integrating system to meet this assertion, such as documenting our expectations on the build environment and locking our dependencies via Cargo.lock et al.

### TA-7

> uProtocol Rust components, configurations and tools are updated under specified change and configuration management controls.

TODO

### TA-8

> Expected or required behaviours for uProtocol Rust components are identified, specified, verified and validated based on analysis.

TODO

### TA-9

> Prohibited misbehaviours for uProtocol Rust components are identified, and mitigations are specified, verified and validated based on analysis.

TODO

### TA-10

> uProtocol (Rust components) releases are constructed from controlled or mirrored sources, and are fully reproducible.

Again, this is something where we can provide assistance and documentation, but we cannot actually provide evidence for directly as we are not in control of our integrating systems.

### TA-11

> uProtocol Rust components, configurations and tools are updated under specified change and configuration management controls.

Documenting our use of GitHub is likely sufficient here, with some expectations placed on the integrating system that they do not defeat such. We will also potentially need to increase the evidences joined with a release to ensure that our downstream integrators are able to achieve this.

### TA-12

> All tests for uProtocol (Rust components), and its build and test environments, are constructed from controlled or mirrored sources.

Control is plausible to some extent, however for normal FOSS methodologies this will not really be possible - As such we will instead aim to provide full documentation of the expectations we place on an integrator to meet this instead; ensuring that nothing we do in our processes would preclude the meeting of this assertion for such downstreams.

### TA-13

> All specified tests are executed repeatedly, under defined conditions in controlled environments, according to specified objectives.

The repeated testing aspect of trusting uProtocol Rust components will be two-pronged. We will set up a regular CI job which can then be used to collect evidence of very basic soak testing by means of running and re-running any test suites which are part of uProtocol directly. However the majority of evidence for this assertion will likely come from the integrating system performing some level of system soak test on a uProtocol service mesh.

### TA-14

> Data is collected from tests, and from monitoring of deployed software, according to specified objectives.

Here our use of a forge such as GitHub will assist. We can define our testing objectives purely around success of the suites, and then use the pipeline results as a way to gather evidence that we're meeting the desired outcomes. As for deployed software monitoring, we will need to provide recommendations on how to do this.

### TA-15

> Collected data from tests and monitoring of deployed software is analysed according to specified objectives.

Effectively the same as TA-14 in terms of what we need to do to get there, and then perhaps some more recommendations for how our integrating systems can analyse outputs.
