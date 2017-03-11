#!/bin/bash

set -e
set -x

: ${deployment_name:-required}
: ${bosh_target:?required}
: ${bosh_username:?required}
: ${bosh_password:?required}
: ${webserver_api:?required}
: ${webserver_username:?required}
: ${webserver_password:?required}

release_name=${release_name:-"stannis"}
manifest_dir=$PWD/manifest

stannis_version=$(cat candidate-release/version)

cat > ~/.bosh_config <<EOF
---
aliases:
  target:
    bosh-lite: ${bosh_target:?required}
auth:
  ${bosh_target}:
    username: ${bosh_username:?required}
    password: ${bosh_password:?required}
EOF

cd boshrelease-ci
mkdir -p tmp

cat > tmp/releases.yml <<EOF
releases:
- name: stannis
  version: ${stannis_version}
EOF

cat > tmp/bosh.yml <<EOF
---
properties:
  bosh_uploader:
    bosh_target: ${bosh_target}
    bosh_username: ${bosh_username}
    bosh_password: ${bosh_password}
    webserver_api: ${webserver_api:?required}
    webserver_username: ${webserver_username:?required}
    webserver_password: ${webserver_password:?required}
EOF

bosh target ${bosh_target}

export DEPLOYMENT_NAME=${deployment_name}
./templates/make_manifest warden \
  tmp/releases.yml tmp/bosh.yml

cp tmp/${DEPLOYMENT_NAME}*.yml ${manifest_dir}/manifest.yml

cat ${manifest_dir}/manifest.yml
