# WAT

Helm for the postgres 'pg_dump' based backup solution [postgres-backup-local](https://github.com/prodrigestivill/docker-postgres-backup-local).
It offers a backup solution with those key features

- schedules
- retentions
- health monitoring of the jobs
- using pg_dump / pg_dumpall as storage formats (not WAL)
- can backup specific databases or all databases (all databases is the default)

You find all the important documentation in the official repository [documentation](https://github.com/prodrigestivill/docker-postgres-backup-local).

This chart does just try to provide an option to run the original image, not introducing any additional functionalities 
or anything else - we keep it vanilla. If you need anything else, ask in [postgres-backup-local](https://github.com/prodrigestivill/docker-postgres-backup-local).

We do not re-publish the docker-image but use the original one published in [postgres-backup-local](https://github.com/prodrigestivill/docker-postgres-backup-local).

# Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/postgres-pgdump-backup
```

## Adjustments / Fixes

- To fix https://github.com/prodrigestivill/docker-postgres-backup-local/issues/76 we are current also exposing `PGUSER`,  `PGPASSWORD`, `PGHOST`,`PGPORT`as additional env variables

## Helm values

Mandatory values to set

- `PGHOST`: hostname/ip of your pg
- `POSTGRES_DB`: comma seperated list of databases to backup, for example: `sko,mattermost,paperless`

For example
```yaml
image:
  tag: "16-debian"

workload:
  main:
    podSpec:
      containers:
        main:
          env:
            POSTGRES_HOST: mypostgres.local
            POSTGRES_DB: sko,mattermost,paperless
```

You will also need to deploy a secret called `postgres-backup-local` (you can rename it, see values.yaml) with the following values
- `POSTGRES_USER` 
- `POSTGRES_PASSWORD`
- `PGUSER` (same values, optional)
- `PGPASSWORD` (same values, optional)

see [values.yaml](./values.yaml) for a full list, but you will need to set

## FAQ

- **How to enable ssl support?** Add this to your values.yaml
  ```yaml
  workload:
    main:
      podSpec:
        containers:
          main:
            env:
              PGSSLMODE: "require"
  ```

## Developing

Test chart-rendering

```bash
helm template . -f values.yaml
```

## Credits

Of course all the credits are going to [postgres-backup-local](https://github.com/prodrigestivill/docker-postgres-backup-local) doing all the important and hard work.

Also credits to [duck-helm/postgres-backup-local](https://artifacthub.io/packages/helm/duck-helm/postgres-backup-local), which was the base of this helm chart when it started.
