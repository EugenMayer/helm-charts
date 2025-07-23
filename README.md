[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/eugen)](https://artifacthub.io/packages/search?repo=eugen)

# WAT

Different kubernetes charts.

- Hopefully using the current standards
- If possible, uses the official docker images

## Chart repository

The chart repository is hosted vi Github-Pages under [chart repository](https://github.com/EugenMayer/helm-charts/tree/gh-pages)
and can be access via

`https://eugenmayer.github.io/helm-charts/`

See an overview of the charts using artifacthub: [![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/eugen)](https://artifacthub.io/packages/search?repo=eugen)

## What it is not

Please do consider the helm charts are **not** build to be a starter for you to understand how to install an application the first time - please use the official docs for that purpose.
Please use the docs of the particular application, learn the Docker environment variables, possible configuration values and all those things.
Please always use the official docs, I will not answer non-chart related questions here.

So it is not a 'how to learn to run rundeck' kind of project. Thank you for respecting that :)

## Index

- [rundeck](charts/rundeck): Rundeck
- [postgres-pgdump-backup](charts/postgres-pgdump-backup): Automated Postgres DB backups
- [iperf3](charts/iperf3): Iperf for network performance tests
- [openldap-test](charts/openldap-test): Pre-Provisioned ldap server for tests
- [vulnz-nvd-mirror](charts/vulnz-nvd-mirror): NVD vuln mirror
- [cert-manager-cloudflare-config](charts/cert-manager-cloudflare-config): Cert Manager Cloudflare ACME config CRD)
- [localpath](charts/localpath): Rancher localpath 
- [whatsmyip](charts/whatsmyip): Responds with your external ip - great for dyndns
- [whoami](charts/whoami): Simple pong service for ingress tests and http header tests
- [coredns-private-dns-fix](charts/coredns-private-dns-fix): Fix coreDNS private DNS resolving
- [ioBroker](charts/iobroker): Home automation ioBroker
- [longhorn-backup-config](charts/longhorn-backup-config): Longhorn backup configuration (CRD)
- [network-tools](charts/network-tools): Multi-Pod network debugging tools
- [gradle-build-cache](charts/gradle-build-cache) Remote and centralized gradle build cache server
- [vikunja](charts/vikunja) Known TODO app. Forked TrueCharts chart to support external Databases.
- [nist-data-mirror (deprecated)](charts/nist-data-mirror)

## Releasing

We are using [chart-releaser](https://github.com/helm/chart-releaser)
This will release all packages that have been changed and update the `index.yaml` under `gh-pages`.

```bash
# export the gh token
 export CR_TOKEN=<token>
make release-all
```
