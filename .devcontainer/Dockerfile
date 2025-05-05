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
ARG TRUSTABLE_RELEASE="trustable-2025.2.18-py3-none-any.whl"
ARG TOML_CLI="toml-0.2.3-x86_64-linux.tar.gz"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    # Others
    curl \
    gcc \
    git \
    python3 \
    python3-venv \
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

# Before installing cargo tools, change to the user that will be used in the container later.
# The reason is that cargo creates some cache, etc. folders with the correct group rustlang, but 
# without making them group writable. Easiest fix is to change to the correct user before the install,
# so that the owner is correct from the start.
USER ${USERNAME}
WORKDIR ${WORKDIR}

# Install doorstop
RUN sudo mkdir /venv
RUN sudo chown ${USERNAME} /venv
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
RUN wget -P /tmp https://gitlab.com/api/v4/projects/66600816/packages/generic/trustable/v2025.02.18/${TRUSTABLE_RELEASE}
RUN pip3 install legacy-cgi 
RUN pip3 install /tmp/${TRUSTABLE_RELEASE}

# Install mush - or not for now; the idea is brilliant but the project is languishing somewhat and doesn't seem to get much adoption
# RUN curl get.javanile.org/mush | sh

# Install toml-cli - to be replaced by json parsing (jq) in the future
RUN wget -P /tmp https://github.com/gnprice/toml-cli/releases/download/v0.2.3/${TOML_CLI}
RUN tar xvfz /tmp/${TOML_CLI} -C /tmp 
RUN sudo find /tmp/ -name 'toml' -exec mv {} /usr/local/bin/ \;