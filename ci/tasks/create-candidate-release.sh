#!/bin/bash

set -e # fail fast
set -x # print commands

OUTPUT="$PWD/candidate-release"
VERSION="$(cat version/number)"
RELEASE_NAME=${RELEASE_NAME:-stannis}

cd boshrelease

bosh -n create release --with-tarball --force --name $RELEASE_NAME --version "$VERSION"
mv dev_releases/$RELEASE_NAME/$RELEASE_NAME-*.tgz "$OUTPUT"
