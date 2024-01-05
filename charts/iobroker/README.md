# WAT

ioBroker in kubernetes - that is what we go for here.

The helm chart is based on the official ioBroker [docker image by buanet](https://github.com/buanet/ioBroker.docker)

This chart is based on [TrueCharts](https://truecharts.org/)

# Configuration

## Ingress

You can enable creating the ingress, just see [values.yaml](values.yaml) - disabled by default.
See more under [ingress](https://truecharts.org/manual/helm/common/ingress/). 

## Volumes

See [values.yaml](values.yaml) under `persistence`. The default is that a PVC is created. More under [persistence](https://truecharts.org/manual/helm/common/persistence/)
You could add custom volume mounts, use NFS mounts, empty dir or whatever you like.

## Env Variables

For now, there are not "quick settings", so all you need to do is set `env` section with what you need, a
[see the reference for possible env vars](https://docs.buanet.de/iobroker-docker-image/docs/#environment-variables-env)

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            DEBUG: true
            PACKAGES: "nfs-common tcpdump"
```

# Network

If you want to attach a specific VLAN and have autodiscovery / multicast / unicast support, please see [README.networking.md](./README.networking.md)


# Buid

```bash
helm dependency build
```

# Credits

Well most of the work has been done on the containerization side by [buanet](https://github.com/buanet) - so give him a heads up on the [project]((https://github.com/buanet/ioBroker.docker)) 
Also credits to the [TrueCharts Team](https://truecharts.org/) for the helm chart library making this one so much easier to implement.
