BOSH release for Stannis
========================

Once you have multiple BOSH, multiple environments, multiple data centers it can quickly become difficult to visualise "what is running? where is it running?"

![deployments](http://cl.ly/image/1d0F153a271D/Deployments.png)

This BOSH release deploys an agent that polls a BOSH for its list of deployments, and relays them to a central Stannis webserver/dashboard.

Usage
-----

To use this bosh release, first upload it to your BOSH:

```
bosh upload release https://bosh.io/d/github.com/cloudfoundry-community/stannis-boshrelease
```

Next, create a `my-bosh.yml` stub that documents that connection credentials to your BOSH, and the details of your Stannis webserver:

```yaml
---
properties:
  bosh_uploader:
    bosh_target: https://50.18.92.50:25555
    bosh_username: admin
    bosh_password: crazypassword

    collector_api: http://our-stannis.cfapps.io
    collector_username: stannis
    collector_password: crazypassword
```

For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
git clone https://github.com/cloudfoundry-community/stannis-boshrelease.git
cd stannis-boshrelease
templates/make_manifest warden my-bosh.yml
bosh -n deploy
```

### Development

As a developer of this release, create new releases and upload them:

```
bosh create release --force && bosh upload release && bosh -n deploy
```
