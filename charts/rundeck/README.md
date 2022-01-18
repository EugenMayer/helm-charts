# WAT

Rundeck helm chart.

History: This chart has been taken from [charts incubator](https://github.com/helm/charts/tree/master/incubator/rundeck) and adopted to newly standards, since the old repository has been archived and is no longer maintained. AWS support has been removed

- removed AWS specific support
- Added database configuration support
- adopted PVC standards
- adopted ingress standards
- added OPTIONS support in nginx
- Fix Grail and CSP issues

# Install

# Install

    helm repo add rundeck http://tba
    helm install rundeck/rundeck

# Configuration

## Mandatory settings

- `externUrl`
- deploy your `rundeck-database-secret` to define the DB credentials and connection informations
- deploy your own `ingress` route or activate `ingress.enabled` and set the values to your liking

## Database

The secret `database.secret_name` must include the following keys

- `jdbc`: The jdbc url like `jdbc:postgresql://$user:$password@$host:$port/$database`
- `user`: DB user
- `password`: DB password
- `type`: one of these `org.postgresql.Driver`/`org.mariadb.jdbc.Driver`/`com.mysql.jdbc.Driver`

See the [docs](https://docs.rundeck.com/docs/administration/configuration/docker.html#database)

## Other Values

| Parameter                  | Description                                                                                                                                                                                | Default                                               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| database.secret_name       | Secret-name with your database credentials and connection details: `type`,`jdbc`,`user`,`password`, You have to create the secret yourself.                                                | None (required)                                       |
| deployment.replicaCount    | How many replicas to run. Rundeck can really only work with one.                                                                                                                           | 1                                                     |
| deployment.annotations     | You can pass annotations inside deployment.spec.template.metadata.annotations. Useful for KIAM/Kube2IAM and others for example.                                                            | {}                                                    |
| deployment.strategy        | Sets the K8s rollout strategy for the Rundeck deployment                                                                                                                                   | { type: RollingUpdate }                               |
| image.repository           | Name of the image to run, without the tag.                                                                                                                                                 | [rundeck/rundeck](https://github.com/rundeck/rundeck) |
| image.tag                  | The image tag to use.                                                                                                                                                                      | 3.2.7                                                 |
| image.pullPolicy           | The kubernetes image pull policy.                                                                                                                                                          | IfNotPresent                                          |
| image.pullSecrets          | The kubernetes secret to pull the image from a private registry.                                                                                                                           | None                                                  |
| service.type               | The kubernetes service type to use.                                                                                                                                                        | ClusterIP                                             |
| service.port               | The tcp port the service should listen on.                                                                                                                                                 | 80                                                    |
| ingress                    | Any ingress rules to apply.                                                                                                                                                                | None                                                  |
| resources                  | Any resource constraints to apply.                                                                                                                                                         | None                                                  |
| rundeck.adminUser          | The config to set up the admin user that should be placed at the realm.properties file.                                                                                                    | "admin:admin,user,admin,architect,deploy,build"       |
| rundeck.env                | The rundeck environment variables that you would want to set. See the [official docs](https://docs.rundeck.com/docs/administration/configuration/docker.html#key-store-security) for more. | Default variables provided in docker file             |
| rundeck.envSecret          | Name of secret containing environment variables to add to the Rundeck deployment                                                                                                           | ""                                                    |
| rundeck.sshSecrets         | A reference to the Kubernetes Secret that contains the ssh keys.                                                                                                                           | ""                                                    |
| rundeck.kubeConfigSecret   | Name of secret to mount under the `~/.kube/` directory. Useful when Rundeck needs configuration for multiple K8s clusters.                                                                 | ""                                                    |
| rundeck.extraConfigSecret  | Name of secret containing additional files to mount at `~/extra/`. Can be useful for working with RUNDECK_TOKENS_FILE configuration                                                        | ""                                                    |
| nginxConfOverride          | An optional multi-line value that can replace the default nginx.conf.                                                                                                                      | ""                                                    |
| persistence.enabled        | Whether or not to attach persistent storage to the Rundeck pod                                                                                                                             | false                                                 |
| persistence.claim.create   | Whether the helm chart should create a persistent volume claim. See the values.yaml for more claim options                                                                                 | false                                                 |
| persistence.existingClaim  | Name of an existing volume claim                                                                                                                                                           | None                                                  |
| serviceAccount.create      | Set to true to create a service account for the Rundeck pod                                                                                                                                | false                                                 |
| serviceAccount.annotations | A map of annotations to attach to the service account (eg: AWS IRSA)                                                                                                                       | {}                                                    |
| serviceAccount.name        | Name of the service account the Rundeck pod should use                                                                                                                                     | ""                                                    |
| volumes                    | volumes made available to all containers                                                                                                                                                   | ""                                                    |
| volumeMounts               | volumeMounts to add to the rundeck container                                                                                                                                               | ""                                                    |
| initContainers             | can be used to download plugins or customise your rundeck installation                                                                                                                     | ""                                                    |
| sideCars                   | can be used to run additional containers in the pod                                                                                                                                        | ""                                                    |

## S3 Execution log storage

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
