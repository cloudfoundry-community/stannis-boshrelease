BOSH release for Stannis
========================

Once you have multiple BOSH, multiple environments, multiple data centers it can quickly become difficult to visualise "what is running? where is it running?"

![deployments](http://cl.ly/image/1d0F153a271D/Deployments.png)

This BOSH release deploys an agent that polls a BOSH for its list of deployments, and relays them to a central Stannis webserver/dashboard.

* CI https://ci.starkandwayne.com/teams/main/pipelines/stannis-boshrelease

Usage
-----

To use this BOSH release to monitor your BOSH and its deployments:

```
git clone https://bosh.io/d/github.com/cloudfoundry-community/stannis-boshrelease
cd stannis-boshrelease
bosh deploy manifests/stannis.yml --vars-file tmp/vars.yml
```

Where `tmp/vars.yml` is a simple YAML file that documents that connection credentials to your BOSH, and the details of your Stannis webserver:

```yaml
---
bosh-target: https://50.18.92.50:25555
bosh-username: admin
bosh-password: crazypassword

webserver-api: http://our-stannis.cfapps.io
webserver-username: stannis
webserver-password: crazypassword
```
