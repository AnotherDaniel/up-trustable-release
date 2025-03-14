################################################################################
# Copyright (c) 2023 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
################################################################################

FROM mcr.microsoft.com/devcontainers/base:dev-ubuntu
ARG USERNAME=vscode
ARG WORKDIR=/up-trustable-release
ARG TRUSTABLE_RELEASE=trustable-2025.2.18-py3-none-any

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
RUN curl https://gitlab.com/api/v4/projects/66600816/packages/generic/trustable/v2025.02.18/${TRUSTABLE_RELEASE}.whl --output ${TRUSTABLE_RELEASE}.whl
RUN pip3 install legacy-cgi 
RUN pip3 install ${TRUSTABLE_RELEASE}.whl

# Install mush
RUN curl get.javanile.org/mush | sh
