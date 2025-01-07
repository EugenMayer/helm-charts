## 0.7.4

- Update truecharts common base

## 0.7.3

- Update truecharts common base

## 0.7.2

- Do not override the POSTGRES_EXTRA_OPTS by default

## 0.7.1

- Update TrueCharts

## 0.7.0

**BREAKING CHANGES!!**
The chart has been migrated to TrueCharts, thus most of the values have been remapped.
Please see the readme on how to map the new values like PGHOST and so forth. Should be a simple mapping.

**Important**: If you used the PVC definition of the chart, the PVC name has been changed, so you most probably either
have to use an existing claim name now (`postgres-pgdump-backup`) to match your pvc - or migrate the data itself. It changed from `postgres-pgdump-backup` to `postgres-pgdump-backup-storage`. You might also need to change the ownership of the volume to `999:999` if you migrated the files.

## 0.6.0

- Use PG 15 by default. You can and should still change it to your PG version via the tag

## 0.5.2

- Ensure we redeploy the pods if the configmap changes - like changing the DBs to backup
