<!--
 * Copyright (C) 2025 Eclipse Foundation and others.
 * 
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License v. 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 * 
 * SPDX-FileType: DOCUMENTATION
 * SPDX-LicenseCopyrightText: 2025 Eclipse Foundation
 * SPDX-License-Identifier: EPL-2.0
-->

# up-trustable-release

The `up-trustable-release` project is a formal release tool for the Eclipse uProtocol project. It integrates uProtocol component release artifact metadata (collected via the `tsffer` GitHub action) with the Eclipse Trustable Software Framework (TSF) methodology, with the goal to generate a TSF score for the corresponding uProtocol release.

This tool automates the process of linking release artifacts to TSF assertions, ensuring traceability and quality observability with the TSF methodology.

## Key Features

- **Artifact Metadata Integration**: Processes metadata generated by the `tsffer` GitHub action to extract relevant information about release artifacts.
- **Artifact Retrieval**: Optionally downloads referenced artifacts based on the metadata.
- **Evidence Generation**: Creates evidence links between release artifacts and TSF assertions, supporting the traceability and trustability of the release.
- **TSF Methodology Compliance**: Aligns with the Eclipse Trustable Software Framework to ensure high-quality, verifiable software releases.

## How It Works

1. **Metadata Parsing**: Reads `.tsffer` files containing metadata about release artifacts.
2. **Artifact Processing**: Extracts key information such as artifact names, descriptions, types, and associated TSF IDs.
3. **Evidence Linking**: Generates evidence files and links them to TSF assertions based on the metadata.
4. **Optional Artifact Download**: Optionally download referenced artifacts, e.g. so that they can be included in an artifact archive for the release.

## Usage

To use this tool, ensure that the workspace is set up correctly and that the required dependencies (e.g., `jq`, `curl`, `doorstop`) are installed. Run the provided scripts to process release artifacts and generate evidence.

### Example Workflow

1. Generate `.tsffer` metadata files in upstream components using the `tsffer` GitHub action; as an example for this, you might refer to the release workflow of the up-rust repository.
2. Retrieve `.tsffer` metadata and optionally the referenced release artifacts using the `get_assets.sh` script.
3. Run the `link_evidence.sh` script to process the metadata and generate evidence links.
