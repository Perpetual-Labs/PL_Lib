# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.241.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# Export DISPLAY, so a XServer can display OMEdit
ARG DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=host.docker.internal:0.0

# Install wget, gnupg, lsb-release
RUN apt-get update \
    && apt install -y wget gnupg lsb-release

# Get the OpenModelica stable version
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | apt-key add -

# Install OpenModelica
RUN apt-get update \
    && apt install -y openmodelica

# Install OpenModelica libraries (like all of them)
#RUN for PKG in `apt-cache search "omlib-.*" | cut -d" " -f1`; do apt-get install -y "$PKG"; done

# Add non-root user for security
#RUN useradd -m -s /bin/bash openmodelicausers
#USER openmodelicausers
#ENV HOME /home/openmodelicausers
#ENV USER openmodelicausers
#WORKDIR $HOME

# Return omc version
CMD ["omc", "--version"]