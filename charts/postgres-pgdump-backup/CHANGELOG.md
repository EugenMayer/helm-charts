## 0.7.0

**BREAKING CHANGES!!**
The chart has been migrated to TrueCharts, thus most of the values have been remapped.
Please see the readme on how to map the new values like PGHOST and so forth. Should be a simple mapping.

## 0.6.0

- Use PG 15 by default. You can and should still change it to your PG version via the tag

## 0.5.2

- Ensure we redeploy the pods if the configmap changes - like changing the DBs to backup
