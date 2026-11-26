# IMPORTANT

This chart has been copied from [TrueCharts](https://github.com/trueforge-org/truecharts/tree/master/charts/stable/vikunja)
and only modified to work with non cnpg external pg databases - that's it. If you are using cnpg, use the truechart chart.

Also things that have been changed:
 - fixed the issue that the configuration is mounted to `/etc/vikunja/config.yaml` while it should be mounted to `/etc/vikunja/config.yml`
 - `postgres.password` configured via the secret
 - `mailer.password` now configured via the secret
 - Removed the defaults for publicurl and frontendurl since they fool the frontend and are nonsense - those are mandatory now
See `postgres:` in the values.yaml.

## Upgrading to 2.x (TrueCharts common 2026)

- `redis.enabled` moved to `dependencies.valkey.enabled`, set your own password in `dependencies.valkey.depconfig.password`
- the bundled valkey is recreated (new StatefulSet/PVC), only cache data is lost. The old `<release>-redis` PVC can be removed
- `cnpg.main.enabled` moved to `dependencies.postgresql.enabled` (disabled by default). A top-level `cnpg:` key in your own values now fails rendering - remove it


## Installation

### Helm-Chart installation

```
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/vikunja
```

For more information on how to install TrueCharts Helm charts, checkout the [instructions on the website](/guides)

## Configuration Options

Important:
 - be sure to set this to your public domain
   ```yaml
   vikunja:
     service:
       # REQUIRED - set this to your domain!
       #publicurl: http://your-vikunja-domain.tld
       #frontendurl: http://your-vikunja-domain.tld
   ```

To view the chart specific options, please view Values.yaml included in the chart.
The most recent version of which, is available here: [values.yaml](values.yaml)

All our Charts use a shared "common" library chart that contains most of the templating and options.
For the complete overview of all available options, please checkout the documentation for them on the [common docs on our website](/common)

For information about the common chart and all defaults included with it, please review its values.yaml file available here: https://github.com/truecharts/public/blob/master/charts/library/common/values.yaml


## Credits

This charts bases on [TrueCharts](https://github.com/trueforge-org/truecharts/tree/master/charts/stable/vikunja) - all the credits go there.

_All Rights Reserved - The TrueCharts Project_
