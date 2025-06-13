# Various notes and ideas for how to do this

## basically

- get doorstop items created by oft-run (oft_spec, oft_impl, oft_utest)
  - would be part of the release artifacts, an archive referenced in manifest.toml
  - would be gotten from release page, extracted to trustable-release worker thing
  - doorstop reports run, and all zipped up for trustable-release artifacts
- reference existing oft reports in their entirety (per release, getting via quevee manifest)
  - workflow that gets a workspace ENV var with the release URL/tag,
  - retrieves the manifest.toml
  - extracts the oft report and creates doorstop links to that

## up-rust release URL example

https://github.com/eclipse-uprotocol/up-rust/releases/tag/v0.5.0

## TODO

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

## devcontainer

- install trudag
- install graphviz
