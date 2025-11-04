################################################################################
# Copyright (C) 2025 Eclipse Foundation and others. 
# 
# This program and the accompanying materials are made available under the
# terms of the Eclipse Public License v. 2.0 which is available at
# http://www.eclipse.org/legal/epl-2.0.
# 
# SPDX-FileType: SOURCE
# SPDX-FileCopyrightText: 2025 Eclipse Foundation
# SPDX-License-Identifier: EPL-2.0
################################################################################

FROM mcr.microsoft.com/devcontainers/base:dev-ubuntu
ARG USERNAME=vscode
ARG WORKDIR=/up-trustable-release

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    curl \
    gcc \
    git \
    python3 \
    python3-pip \
    python3-venv \
    pipx \
    zip \
    && \
    rm -rf /var/lib/apt/lists/*

# Install gh binary
RUN (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

# Before installing tools, change to the user that will be used in the container later.
USER ${USERNAME}

# Python being a burning heap of things: this is the only way I found to make this install work, with all needed depedencies
# available so that running trudag actually accepts them all.
RUN pipx install poetry
RUN pip install --break-system-packages pyyaml typing_extensions
RUN pip install --break-system-packages trustable --index-url https://gitlab.com/api/v4/projects/66600816/packages/pypi/simple
