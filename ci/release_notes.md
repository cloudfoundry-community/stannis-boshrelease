* [BREAKING] `stannis-agent` now supports/requires `bosh_ca_cert` for your BOSH environment; additionally all job properties for `stannis-agent` have been updated and require you to rename/update:

    From the `manifests/stannis.yml`:

    ```yaml
    properties:
      bosh_uploader:
        bosh_environment: ((bosh_environment))
        bosh_ca_cert: ((bosh_ca_cert))
        bosh_client: ((bosh_client))
        bosh_client_secret: ((bosh_client_secret))
        webserver_api: ((webserver_api))
        webserver_username: ((webserver_username))
        webserver_password: ((webserver_password))
    ```

* Internally, `stannis` is using a yet-to-be released `bosh curl` command to interact with the BOSH director from https://github.com/cloudfoundry/bosh-cli/pull/408
* The BOSH release has switched to using [language packs](https://starkandwayne.com/blog/build-bosh-releases-faster-with-language-packs/) for Ruby and Golang
