# WAT

Chart to host a NIST mirror - see https://github.com/jeremylong/Open-Vulnerability-Project/vulnz
It syncs and serves the NVD (CPE/CVE JSON) data from NIST.

This cache offers the v2 API of NVD, while [nist-data-mirror](../nist-data-mirror), offers v1.

On pod start, there should be an initial / direct preseed of the cache once (so you do not need to wait for the cron job)

# Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/vulnz-nvd-mirror
```

# Configuration
You can tweak the configuration. In general, you can mass any ENV var you like using the map.
For example to adjust the memory usage or set any additional env var

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            JAVA_OPT: -Xmx2g
```

### API key

There is a rate limit that can be eased by creating an API key on NVDs side. To let your mirror use the API key create secret
with the key `NVD_API_KEY` and your API key as the value

Either add your API key as ENV value directly
```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            NVD_API_KEY: YOUR-API-KEY
```

Or via a secret you created:

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            NVD_API_KEY:
              secretKeyRef:
                name: nvd-api-key-secret-ref
                key: password
```

Of course, you can change the secret name if you like.

### Refresh data

The data is refreshed every night using a cron-job. If you want to do it manually, you connect to the container and run

```bash
/mirror.sh
```

### Gradle plugin

To use the API cache, configure gradle to use

```groovy
dependencyCheck {
    nvd {
        validForHours = 24
        // Replace https://your-mirror-url.com with your ingress domain / schema
        // keep /nvdcve-{0}.json.gz
        datafeedUrl = "https://your-mirror-url.com/nvdcve-{0}.json.gz"
        // no need to drive a high delay since we use our own mirror
        delay = 10
    }
}
```
## Chart

### Ingress

See the [values.yml](values.yaml) 
A minimal example would be
```yaml
ingress:
  main:
    enabled: true
    ingressClassName:  "nginx"
    hosts:
      -  host: vulnz-mirror.com
         paths:
           - path: /
             pathType: Prefix
```

### Volumes / PVC

By default the cached mirror data is persistence, see persistence in [values.yml](values.yaml)

### Values

Check the [values.yml](values.yaml)  file

# Credits

All the credits to [jeremylong](https://github.com/jeremylong/Open-Vulnerability-Project/vulnz) doing the actual work.
This is just the helm chart finishing :)
