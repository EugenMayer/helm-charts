[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/eugen)](https://artifacthub.io/packages/search?repo=eugen)

# WAT

Different kubernetes charts.

- Hopefully using the current standards
- If possible, uses the official docker images

## Chart repository

The chart repository is hosted vi Github-Pages under [chart repository](https://github.com/EugenMayer/helm-charts/tree/gh-pages)
and an be access via

`https://eugenmayer.github.io/helm-charts/`

See an overview of the charts using artifacthub: https://artifacthub.io/badge/repository/eugen

## What it is not

Please do consider the helm charts are **not** build to be a starter for you to understand how to install an application the first time.
Please use the docs of the particular application, learn the Docker environment variables, possible configuration values and all those things.
Please always use the official docs, I will not answer non-chart related questions here.

So it is not a 'how to learn to run rundeck' kind of project. Thank you for respecting that :)

## Index

- [rundeck](charts/rundeck)
- [postgres-pgdump-backup](charts/postgres-pgdump-backup)
- [iperf3](charts/iperf3)

## Releasing

We are using [chart-releaser](https://github.com/helm/chart-releaser)
This will release all packages that have been changed and update the `index.yaml` under `gh-pages`.

```bash
# export the gh token
 export CR_TOKEN=<token>
make release-all
```
