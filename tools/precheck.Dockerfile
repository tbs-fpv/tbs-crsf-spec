# This dockerfile is used to build the image used for CI precheck stage jobs
# Precheck jobs currently require the following:
#   - pre-commit and all hooks
#
# This repository has multiple Dockerfiles. Thus, when build this Dockerfile
# for the GitLab container registry, please use this Dockerfile's path
# in the image's name. For example `<registry_path>/tools/precheck:latest`.
# CI jobs will then reference this image using the naming convention above. For
# example: `$CI_REGISTRY_NAME/tools/precheck:latest`.
#
# Example build command
#
# docker build -f ./tools/precheck.Dockerfile -t <registry_path>/tools/precheck:latest .
#
# Please remember to update the GitLab YAML to use the latest image if this file
# is updated and rebuilt.

# Use latest security status Python 3 release (v3.11). Alpine variant for
# minimal size.
FROM registry.hub.docker.com/library/python:3.11-alpine

# Install Git
RUN apk add --no-cache git && \
    rm -rf /var/cache/apk/*

# Install latest minor version (v4.0) of pre-commit
RUN pip install --no-cache-dir pre-commit==4.0.*

# Move working directory to initialize empty Git repository and install
# pre-commit hooks.
WORKDIR /builds

# Copy in pre-commit configuration from build context
COPY .pre-commit-config.yaml ./.pre-commit-config.yaml

# Initialize empty git repository, install pre-commit hooks, then cleanup
RUN git init && \
    pre-commit install-hooks && \
    rm ./.pre-commit-config.yaml && \
    rm -rf .git

# Restore working directory back to root and set entrypoint to shell.
# - Users who build this image locally will have a shell entry point with
#   pre-commit hooks already installed
# - These steps are redundant for GitLab jobs always override entrypoint to
#   shell and working directory to /builds/<project-path>/
WORKDIR /
ENTRYPOINT ["/bin/sh"]
