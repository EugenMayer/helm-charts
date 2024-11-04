# WAT

Lets you host the gradle build cache on your k8s cluster - uses the official [docker container](https://hub.docker.com/r/gradle/build-cache-node/).

### Config

If you want to provide a config, you need to deploy a secret with the key `config.yaml`, holding the configuration as 
a base64 encoded string. See the (official docs)(https://docs.gradle.com/build-cache-node/#editing_the_file). 
You will then need to enable it in the `persistence.config-secret`, and if you used a custom name,
override `objectName`

```yaml
persistence:
  config-secret:
    enabled: true
    objectName: 'gradle-cache-config'
```

### Volumes / PVC

By default the cached mirror data is persistence, see persistence in [values.yml](./values.yaml)

### Values

Check the [values.yml](./values.yaml)  file

# Credits

All the credits to [gradles build cache](https://docs.gradle.com/build-cache-node/) doing the actual work.
