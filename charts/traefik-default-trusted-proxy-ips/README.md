# WAT

Currently based on https://github.com/zekihan/traefik-real-ip

# Install

Be sure to deploy the https://github.com/zekihan/traefik-real-ip within traefik

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/traefik-default-middlewares
```

# Why

Since `Middleware` is a CRD you cannot deploy Traefik via the helm-chart AND also deploy this configuration
since it won't be known in the same deployment (in terraform). It is pragmatic to have a simple config chart deploying 
that specific CRD, so you can depend on it.
