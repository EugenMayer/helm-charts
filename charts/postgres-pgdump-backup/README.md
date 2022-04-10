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

## Helm values

Hopefully most of them are self-explaining. You might habe a look on `configmaps.yaml` to understand, what values
are mapped in which [environment variables of the actual image](https://github.com/prodrigestivill/docker-postgres-backup-local#environment-variables=)

If any values are unclear, open an issue or a PR explaining those. Happy to include docs here for anything needed

### Mandatory values

- `image.tag` - set this to your pg version, see [docker available tags](https://hub.docker.com/r/prodrigestivill/postgres-backup-local/tags)
- `postgres.host` - set this to your postgres host
- `postgres.auth.existingSecretName` - set this to the existing secret holding `POSTGRES_USER` and `POSTGRES_PASSWORD`. Alternatively set `postgres.auth.user` and `postgres.auth.password`

## Credits

Of course all the credits are going to [postgres-backup-local](https://github.com/prodrigestivill/docker-postgres-backup-local) doing all the important and hard work.

Also credits to [duck-helm/postgres-backup-local](https://artifacthub.io/packages/helm/duck-helm/postgres-backup-local), which was the base of this helm chart when it started.
