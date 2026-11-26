## 0.3.0

- Update TrueCharts common to 32.9.0 ("common 2026"). The rendered manifests are unchanged with the default values, but common now rejects some removed/legacy keys - check your own value overrides
- Fix the `tls` service failing to render ("Expected enabled service to have at least one port"): its port is now explicitly enabled and named `tls`

## 0.2.1

- Update truecharts common base

## 0.2.0

- Switch from osixia to bitnami docker images. Adopt configuration


## 0.1.1

- Fix smaller service declaration issues

## 0.1.0

**BREAKING CHANGE**

- Migrate to Truecharts
