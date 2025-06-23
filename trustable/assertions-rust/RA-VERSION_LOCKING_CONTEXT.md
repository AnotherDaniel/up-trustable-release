---
level: 3.3.1
normative: false
---

A Rust project can explicitly determine how it deals with its dependencies depending on whether `Cargo.lock` is managed in version control or not:

**For Applications/Binaries:**

Should commit `Cargo.lock` to ensure reproducible builds. This guarantees that everyone working on the project and your deployment environments use exactly the same dependency versions. Without it, `cargo build` might pull newer versions that could introduce breaking changes or subtle bugs between environments.

**For Libraries/Crates:**

Should typically exclude Cargo.lock from version control (add it to .gitignore). Libraries are meant to be flexible with their dependency versions within the constraints specified in Cargo.toml. When someone depends on a crate, they'll generate their own lock file based on their full dependency tree. Including the lock file could create conflicts or prevent users from getting compatible versions of transitive dependencies.

**Key Trade-offs:**

*Reproducibility vs Flexibility* - Committing the lock file prioritizes identical builds over getting the latest compatible dependency updates. This is usually desirable for applications but not for libraries.

*Security Updates* - With a committed lock file, a project won't automatically get security patches in dependencies. It is required to explicitly run `cargo update` to refresh dependencies while respecting Cargo.toml constraints.

*CI/CD Considerations* - Committed lock files make CI builds faster and more reliable since dependency resolution is already done. However, it is probably useful to have separate CI jobs that test with updated dependencies to catch compatibility issues early.

The general rule is: commit Cargo.lock for end products you deploy, exclude it for libraries you publish.
