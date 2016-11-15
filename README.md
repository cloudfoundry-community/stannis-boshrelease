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

    webserver_api: http://our-stannis.cfapps.io
    webserver_username: stannis
    webserver_password: crazypassword
```

For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy a cluster:

```
git clone https://github.com/cloudfoundry-community/stannis-boshrelease.git
cd stannis-boshrelease
templates/make_manifest warden my-bosh.yml
bosh -n deploy
```

### Monitor AWS RDS snapshots

If your deployments are known to use AWS RDS servers then there is a Stannis plugin that can monitor the age of last RDS snapshots.

Add the following to your deployment manifest:

```yaml
# demo ge-predix
aws:
  aws_access_key_id: KEY
  aws_secret_access_key: SECRET

aws_snapshots:
  deployments:
    - bosh_really_uuid: BOSHIP-BOSHUUID
      deployment_name: prod-cf
      label: backups-rds
      rds:
      - instance_id: ccdb-prod
      - instance_id: uaadb-prod
```

Note: `instance_id` must be converted to use hyphens instead of underscores if your RDS name used underscores.

Development
-----------

As a developer of this release, create new releases and upload them:

```
bosh create release --force && bosh upload release && bosh -n deploy
```
