# WAT

Offers ranchers local-path as helm chart

# Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/coredns-private-dns-fix
```

# Future

Migrate to https://github.com/rancher/local-path-provisioner/tree/master/deploy/chart/local-path-provisioner when it becomes 
available as a chart.

# Upgrade

Copied/copy from https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml to [templates/](templates/localpath.yaml)
