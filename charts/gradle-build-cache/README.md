# WAT

Lets you host the official gradle build cache on your k8s cluster - uses the official [docker container](https://hub.docker.com/r/gradle/build-cache-node/) by the Gradle team and wraps it in a simple chart.

### Config

If you want to provide your config (which you most probably will do in prodduction), you need to deploy a k8s secret that includes a key   `config.yaml`, holding the entire/vanilla gradle-build-cache configuration-yaml as 
a base64 encoded string. See the (official docs)(https://docs.gradle.com/build-cache-node/#editing_the_file). 
You will then need to enable it in the `persistence.config-secret`, and if you used a custom name,
override `objectName`

```yaml
persistence:
  config-secret:
    enabled: true
    objectName: 'gradle-cache-config'
```

### Persistence

By default, the cache data is persistent, see persistence in [values.yml](./values.yaml)

### Values

Check the [values.yml](./values.yaml)  file

# Credits

All the credits to [gradles build cache](https://docs.gradle.com/build-cache-node/) doing the actual work.
