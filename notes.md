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
