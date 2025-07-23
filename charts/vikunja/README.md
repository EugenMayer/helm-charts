# IMPORTANT

This chart has been copied from [TrueCharts](https://github.com/trueforge-org/truecharts/tree/master/charts/stable/vikunja)
and only modified to work with non cpng external pg databases - that's it. If you are using cpng, use the truechart chart.

See `postgres:` in the values.yaml.

Other changes:
    - `postgres.password` configured via the secret
    - `mailer.password` now configured via the secret


## Installation

### Helm-Chart installation

```
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/vikunja
```

For more information on how to install TrueCharts Helm charts, checkout the [instructions on the website](/guides)

## Configuration Options

To view the chart specific options, please view Values.yaml included in the chart.
The most recent version of which, is available here: [values.yaml](values.yaml)

All our Charts use a shared "common" library chart that contains most of the templating and options.
For the complete overview of all available options, please checkout the documentation for them on the [common docs on our website](/common)

For information about the common chart and all defaults included with it, please review its values.yaml file available here: https://github.com/truecharts/public/blob/master/charts/library/common/values.yaml


## Credits

This charts bases on [TrueCharts](https://github.com/trueforge-org/truecharts/tree/master/charts/stable/vikunja) - all the credits go there.

_All Rights Reserved - The TrueCharts Project_
