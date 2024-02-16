# WAT

Lets you deploy a Longhorn Backup Definition (CRD) via a helm, which helps deploying via terraform when rolling out
an entire cluster at ones (CRD henn egg problem)

## Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/longhorn-backup-config
```
