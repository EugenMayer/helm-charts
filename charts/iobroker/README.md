# WAT

ioBroker in kubernetes - that is what we go for here.

The helm chart is based on the official ioBroker [docker image by buanet](https://github.com/buanet/ioBroker.docker)

# Configuration

## Ingress

You can enable creating the ingress, just see [values.yaml](values.yaml).
Be sure to set
- `ingress.className` - your ingress class
- `ingress.hosts[].host` - your domain you want to access ioBroker with
- if needed the usual annotation / tls parts for TLS/ACME

## Volumes

See [values.yaml](values.yaml) you can enable or disable the volume at `/opt/iobroker`.
You can either 
- enable and let it auto-carete the PVC (default)
- or enable it, but disable the creation, providing your own
- disable it entirely - no persistence

## Env Variables

For now, there are not "quick settings", so all you need to do is set `iobroker.env` with what you need, a
[see the reference for possible env vars](https://docs.buanet.de/iobroker-docker-image/docs/#environment-variables-env)

```yaml
iobroke:
  env:
    DEBUG: true
    PACKAGES: "nfs-common tcpdump" 
```

# Network

More to come (expect to use multus / macvlan)

# Credits

Well most of the work has been done on the containerization side by [buanet](https://github.com/buanet) - so give him a heads up on the [project]((https://github.com/buanet/ioBroker.docker)) 
