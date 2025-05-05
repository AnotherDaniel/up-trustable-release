#!/bin/bash

# Copyright (C) 2025 Eclipse Foundation and others. 
# 
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0 which is available at
# http://www.eclipse.org/legal/epl-2.0.
# 
# SPDX-FileType: SOURCE
# SPDX-FileCopyrightText: 2025 Eclipse Foundation
# SPDX-License-Identifier: EPL-2.0


# Need to set GH_TOKEN to enable gh binary operation - a fine-grained access token with repo:read-only access for the referenced components will do
source ./.env

#export UP_TSF_COMPONENT_RELASES="['https://github.com/eclipse-uprotocol/up-rust/releases/tag/v0.5.0', 'https://github.com/eclipse-uprotocol/up-transport-zenoh-rust/releases/tag/v0.5.0']"
export UP_TSF_COMPONENT_RELASES="['https://github.com/AnotherDaniel/up-rust/releases/tag/v0.0.1']"
