# Various notes and ideas for how to do this

## EF Handbook

- projects must use git
- must work directly in open repo (no periodic private syncs)
- must use public issue trackers in eg GitHub
- authors must provide name, have ECA signed (no anonymous contributions)
- PRs should mention issue ID
- Roles, and the associated rights, responsibilities and access levels for GitHub or GitLab
- SBOMs encouraged, for supply chain security
- SECURITY.md encouraged for security reporting advice
- EF is a CVE numbering authority
- detailed CVE reporting process

## TODO

- tsffer feature: link-as-evidence (in addition to pointing to files)
- 

- link to specific locations of individual requirements (e.g. link to build CI stuff)
  - have TSF assertion/evidence items prepared manually
  - where? - up-rust, folder
    - link req (req~up-language-ci-build~1) to TSF ID
      - [.specitem,oft-sid="req~up-language-ci-build~1",oft-needs="impl",oft-title="CI asserts that library can be built"]
      - [impl->req~up-language-ci-build~1]

      - [.specitem,oft-sid="dsn~cloudevents-umessage-mapping~2",oft-needs="impl,utest",oft-title="Mapping of UMessages to CloudEvents"]
      - [impl->dsn~cloudevents-umessage-mapping~2]
      - [utest->dsn~cloudevents-umessage-mapping~2]

- behavior if output directory/files already present - force switch, etc

## TSF application

- check.yaml last action -> TA-ITERATIONS


## devcontainer

- install trudag
- install graphviz
