---
active: true
derived: false
level: 1.9
links:
- up_TA-002: i0hFdthR8UYycoPrD8fPilNzmQ4kx0cXM-b3zcoDwTU=
normative: true
ref: ''
reviewed: zcJxsGCRwpJQtjeAk6ZiSZl0zv7gnPtoSMuSf1DXaOM=
---

`up-rust` uses cargo-deny for vetting dependencies for license compliance, security advisories and project liveness. An example for a project-is-unmaintained adivsory [can be seen here](https://rustsec.org/advisories/RUSTSEC-2025-0014). Using this crate in the project will cause cargo deny to issue the following error, breaking the build:

```shell
error[unmaintained]: humantime is unmaintained
    ┌─ /home/runner/work/up-subscription-rust/up-subscription-rust/Cargo.lock:100:1
    │
100 │ humantime 2.1.0 registry+https://github.com/rust-lang/crates.io-index
    │ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ unmaintained advisory detected
    │
    ├ ID: RUSTSEC-2025-0014
    ├ Advisory: https://rustsec.org/advisories/RUSTSEC-2025-0014
    ├ Latest `humantime` crates.io release is four years old and GitHub repository has
      not seen commits in four years. Question about maintenance status has not gotten
      any reaction from maintainer: https://github.com/tailhook/humantime/issues/31

      ## Possible alternatives

       * [jiff](https://crates.io/crates/jiff) provides same kind of functionality
    ├ Announcement: https://github.com/tailhook/humantime/issues/31
    ├ Solution: No safe upgrade is available!
```
