# Various notes and ideas for how to do this

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
