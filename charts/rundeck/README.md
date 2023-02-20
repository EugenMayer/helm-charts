[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/eugen)](https://artifacthub.io/packages/search?repo=eugen)

# WAT

Rundeck helm chart.

History: This chart has been taken from [charts incubator](https://github.com/helm/charts/tree/master/incubator/rundeck) and adopted to newly standards, since the old repository has been archived and is no longer maintained.

- Added database configuration support
- add proper secret for user creation (`realm.properties`)
- add configuration to the `rundeck-config.properties`
- add configuration to the `framework.properties`
- add proper support for plugins
- add proper default volumes and claims
- handle security context properly to fix volume mounts
- Fix Grail and CSP issues
- adopted PVC standards
- adopted ingress standards
- added OPTIONS support in nginx
- Add execution-logs handling by default (local storage)
- split nginx and rundeck-backend deployments

If you migrate from the incubator please consider breaking changes and read any aspect of this helm chart. Do not expect
to just switch out the helm source.

# Strong hint

This helm chart is not a place to fix the lack of documentation available for rundeck, it's environment variables or
plugin concepts in general. So please do **not** open issues for questions like 'How to configure AWS s3 storage' or
'is there an environment variable for X or Y.

Please open or ask all those questions in one of the [official channels](https://docs.rundeck.com/docs/introduction/getting-help.html).

# Install

    helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
    helm install eugenmayer/rundeck

# Configuration

## Mandatory settings / Initial setup

- `externUrl`
- `executionLogs.claim.storageClass` / `data.claim.storageClass` / `plugins.claim.storageClass` / `addons.claim.storageClass` or disable those (or some)
- deploy your `user-credentials-secret` secret (in your rundeck namespace) with the field `userCredentials` including the string (at least)`admin:PASSWORD,user,admin,architect,deploy,build`
  - replace `PASSWORD` with your password
  - add as many as you like, seperate by newlines `\n`
- deploy your `rundeck-database-secret` to define the DB credentials and connection details or use `database.useInternalH2db` (only for non-production). See `Database` below.
- deploy your own `ingress` route (default) or activate `ingress.enabled` and set the values to your liking

## Database

For production usage, the secret `database.secret_name` must include the following keys

- `jdbc`: The jdbc url like `jdbc:postgresql://$user:$password@$host:$port/$database`
- `user`: DB user
- `password`: DB password
- `type`: one of these `org.postgresql.Driver`/`org.mariadb.jdbc.Driver`/`com.mysql.jdbc.Driver`

See the [docs](https://docs.rundeck.com/docs/administration/configuration/docker.html#database)

For development usage, the `database.useInternalH2db` flag can be set to true, in which case rundeck will use the embedded database at `jdbc:h2:file:/home/rundeck/server/data/grailsdb;MVCC=true`. This is only meant for pure development and testing, never use on a production environment (see [docs for default](https://docs.rundeck.com/docs/administration/configuration/docker.html#basic) and [database docs](https://docs.rundeck.com/docs/administration/configuration/docker.html#basic)).

## Execution logs

By default the execution logs are saved on the `execution-logs` volume under the default undeck location `/home/rundeck/var/logs/rundeck`.
You can disable the `claim` and use any other execution-log storage (be aware, the OSS docker image has no support for s3, see below)

## Plugins

Due to the [limitations](https://github.com/rundeck/rundeck/issues/7487) of rundeck's docker-image, plugin support is implemented
using a hack - nothing more.

If you want to use plugins you have to

- use an `initContainer`
- mount the volume `rundeck-plugins` to `/mnt/plugins` in the `initContainer`

To do so put this (as an example for the `s3` plugin) into your `values.yaml`

```yaml
initContainers:
  - name: plugins-download
    image: curlimages/curl
    imagePullPolicy: IfNotPresent
    command: ["/bin/sh"]
    args:
      - -c
      - >
        curl -L --fail https://github.com/rundeck-plugins/rundeck-s3-log-plugin/releases/download/v1.0.12/rundeck-s3-log-plugin-1.0.12.jar --output /mnt/plugins/rundeck-s3-log-plugin-1.0.12.jar;
    volumeMounts:
      - name: rundeck-plugins
        mountPath: /mnt/plugins
```

Background: When the rundeck-backend image starts, we override the command, copy the plugins first and then call the actual
command to continue the boostrap. Hopefully the [issue](https://github.com/rundeck/rundeck/issues/7487) will be solved at some point, making this entire backflip unneeded.

## Configuration

You can configure `rundeck-config.properties` and `framework-properties` via `ConfigMaps` - see `rundeck.rundeckConfigConfigMap` and `rundeck.rundeckFrameworkConfigMap` in `values.yaml`

If you change the values, you usually have to manually restart the pod so those values are applied, since k8s caches the config maps.

## Addons

Similar to plugins, mount `rundeck-addons` using an init container and download your addons(s)

## S3 Execution log storage

**ATTENTION**: this is NOT working due to [rundeck oss version limitations](https://github.com/rundeck/rundeck/issues/7490)

See https://docs.rundeck.com/docs/administration/cluster/logstore/s3.html#install

You usuall add something like this to your values

```yaml
env:
  # see https://docs.rundeck.com/docs/administration/cluster/logstore/s3.html#install
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_NAME: "org.rundeck.amazon-s3"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_BUCKET: "rundeck-execution-logs"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_REGION: "eu-central-1"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_AWSACCESSKEYID: "awskey"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_AWSSECRETKEY: "awssecret"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_ALLOWDELETE: "true"
  RUNDECK_PLUGIN_EXECUTIONFILESTORAGE_S3_PATH: "logs/$${job.project}/logs/$${job.execid}.log"
```

Of course you will need to adjust the bucket, region, key and secret (at least)

## Other Values

It is better to read the `values.yaml` itself - but here is somewhat of an overview about the options (not all).

| Parameter                        | Description                                                                                                                                                                                | Default                                               |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| database.secret_name             | Secret-name with your database credentials and connection details: `type`,`jdbc`,`user`,`password`, You have to create the secret yourself.                                                | None (required)                                       |
| executionLogs.claim.enabled      | If you plan to store execution logs locally, enable the claim.                                                                                                                             | true                                                  |
| executionLogs.claim.storageClass | If you enabled local execution-logs, set your storage class                                                                                                                                | None (required)                                       |
| data.claim.enabled               | If enabled, mounts a volume for the server data [what is it used for?](https://github.com/rundeck/rundeck/issues/7488)                                                                     | true                                                  |
| data.claim.storageClass          | Set the storage class for the server data volume [what is it used for?](https://github.com/rundeck/rundeck/issues/7488)                                                                    | None (required)                                       |
| plugins.claim.enabled            | If enabled, mounts a volume for the plugins. Those will be copied to `/home/rundeck/libexex/`                                                                                              | true                                                  |
| plugins.claim.storageClass       | Set the storage class for the plugins volume                                                                                                                                               | None (required)                                       |
| addons.claim.enabled             | If enabled, mounts a volume for the server addons - special addons for the enterprise editions (not plugins)                                                                               | true                                                  |
| addons.claim.storageClass        | Set the storage class for the server addons volume                                                                                                                                         | None (required)                                       |
| deployment.replicaCount          | How many replicas to run. Rundeck can really only work with one.                                                                                                                           | 1                                                     |
| deployment.annotations           | You can pass annotations inside deployment.spec.template.metadata.annotations. Useful for KIAM/Kube2IAM and others for example.                                                            | {}                                                    |
| deployment.strategy              | Sets the K8s rollout strategy for the Rundeck deployment                                                                                                                                   | { type: RollingUpdate }                               |
| image.repository                 | Name of the image to run, without the tag.                                                                                                                                                 | [rundeck/rundeck](https://github.com/rundeck/rundeck) |
| image.tag                        | The image tag to use.                                                                                                                                                                      | 3.2.7                                                 |
| image.pullPolicy                 | The kubernetes image pull policy.                                                                                                                                                          | IfNotPresent                                          |
| image.pullSecrets                | The kubernetes secret to pull the image from a private registry.                                                                                                                           | None                                                  |
| service.type                     | The kubernetes service type to use.                                                                                                                                                        | ClusterIP                                             |
| service.port                     | The tcp port the service should listen on.                                                                                                                                                 | 80                                                    |
| ingress                          | Any ingress rules to apply.                                                                                                                                                                | None                                                  |
| resources                        | Any resource constraints to apply.                                                                                                                                                         | None                                                  |
| rundeck.adminUser                | The config to set up the admin user that should be placed at the realm.properties file.                                                                                                    | "admin:admin,user,admin,architect,deploy,build"       |
| rundeck.env                      | The rundeck environment variables that you would want to set. See the [official docs](https://docs.rundeck.com/docs/administration/configuration/docker.html#key-store-security) for more. | Default variables provided in docker file             |
| rundeck.envSecret                | Name of secret containing environment variables to add to the Rundeck deployment                                                                                                           | ""                                                    |
| rundeck.sshSecrets               | A reference to the Kubernetes Secret that contains the ssh keys.                                                                                                                           | ""                                                    |
| rundeck.kubeConfigSecret         | Name of secret to mount under the `~/.kube/` directory. Useful when Rundeck needs configuration for multiple K8s clusters.                                                                 | ""                                                    |
| rundeck.extraConfigSecret        | Name of secret containing additional files to mount at `~/extra/`. Can be useful for working with RUNDECK_TOKENS_FILE configuration                                                        | ""                                                    |
| nginxConfOverride                | An optional multi-line value that can replace the default nginx.conf.                                                                                                                      | ""                                                    |
| serviceAccount.create            | Set to true to create a service account for the Rundeck pod                                                                                                                                | false                                                 |
| serviceAccount.annotations       | A map of annotations to attach to the service account (eg: AWS IRSA)                                                                                                                       | {}                                                    |
| serviceAccount.name              | Name of the service account the Rundeck pod should use                                                                                                                                     | ""                                                    |
| volumes                          | volumes made available to all containers                                                                                                                                                   | ""                                                    |
| volumeMounts                     | volumeMounts to add to the rundeck container                                                                                                                                               | ""                                                    |
| initContainers                   | can be used to download plugins or customize your rundeck installation                                                                                                                     | ""                                                    |
| sideCars                         | can be used to run additional containers in the pod                                                                                                                                        | ""                                                    |

## Test

To test if the templates compile

```bash
helm template . -f values.yaml -f values-test.yaml
```

### License

It is explicitly forbidden to be used as a work to derive from for any purpose by PagerDuty or Rundeck the coorporate. It cannot be included in any work offered on their website or as a base to anything else by the company. So if your are an employee of PagerDuty, Rundeck or do work for them commercially, you cannot use this chart.

Anybody else can use this helm chart for what ever they like - without warranties included of course
