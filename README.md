# BOSH release for Stannis

Once you have multiple BOSH, multiple environments, multiple data centers it can quickly become difficult to visualise "what is running? where is it running?"

![deployments](http://cl.ly/image/1d0F153a271D/Deployments.png)

This BOSH release deploys an agent that polls a BOSH for its list of deployments, and relays them to a central [Stannis webserver/dashboard](https://github.com/cloudfoundry-community/stannis).

* CI https://ci2.starkandwayne.com/teams/cfcommunity/pipelines/stannis-boshrelease

## Requirements

Prior to deploying the Stannis BOSH release to run the Stannis agent and collect BOSH deployment information, you need to run the [Stannis webserver/dashboard](https://github.com/cloudfoundry-community/stannis) somewhere that your Stannis agent AND humans can access. That's the point of Stannis - making it easy for humans to view what is deployed across all their hard-to-reach BOSH environments.

## Usage

To use this BOSH release to monitor your BOSH and its deployments:

```plain
git clone https://github.com/cloudfoundry-community/stannis-boshrelease
bosh deploy -d stannis \
    stannis-boshrelease/manifests/stannis.yml \
    -o stannis-boshrelease/manifests/operators/use-compiled-releases.yml
```

You will either need to populate CredHub or pass a `-l vars.yml` file with the credentials for your BOSH director (currently a BOSH deployment cannot link to its own BOSH director), and the central Stannis webserver.

For example, a `vars.yml` might look like:

```yaml
bosh_environment: https://50.18.92.50:25555
bosh_client: admin
bosh_client_secret: crazypassword
bosh_ca_cert: |-
    ...

webserver_api: http://our-stannis.cfapps.io
webserver_username: stannis
webserver_password: crazypassword
```

## Integrate with BUCC

[BUCC](https://github.com/starkandwayne/bucc) is the easiest way to run and upgrade BOSH environments. You can easily integrate the Stannis agent (this BOSH release) with BUCC. Create an `operators` folder, add in two files, and re-run `bucc up`:

```plain
cd path/to/bucc
mkdir -p operators
curl https://raw.githubusercontent.com/cloudfoundry-community/stannis-boshrelease/master/manifests/operators/create-env.yml -o operators/8-stannis-create-env.yml
curl https://raw.githubusercontent.com/cloudfoundry-community/stannis-boshrelease/master/manifests/operators/use-compiled-releases.yml -o operators/9-stannis-use-compiled-releases.yml
```

BUCC will provide the credentials to Stannis for the BOSH environment, but you need to provide the `webserver_api/username/password` variables. Add the following to `vars.yml`:

```yaml
webserver_api: http://our-stannis.cfapps.io
webserver_username: stannis
webserver_password: crazypassword
```

Finally, re-deploy your BUCC/BOSH environment:

```plain
bucc up
```

## Development

To create/upload/deploy a development version of this BOSH release:

```plain
git clone https://github.com/cloudfoundry-community/stannis-boshrelease
cd stannis-boshrelease
bosh deploy -d stannis \
    manifests/stannis.yml \
    -o manifests/operators/create.yml
```
