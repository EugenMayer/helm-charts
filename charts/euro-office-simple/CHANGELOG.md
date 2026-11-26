## 0.1.0

**BREAKING**: migrated to TrueCharts common 32.9.0 ("common 2026")

- Update euro-office documentserver from v9.3.4 to v9.3.8
- Update common from 29.10.4 to 32.9.0
- Migrate `cnpg.main.enabled: false` to `dependencies.postgresql.enabled: false` (the top-level `cnpg` key is no longer supported by common), the built-in PostgreSQL stays disabled
- Add the missing `apiVersion: v2` to `Chart.yaml` and replace the legacy `requirements.lock` with `Chart.lock`
- Fix the chart description and home/source URLs (copied over from vikunja)

## 0.0.1

Initial release of 9.3.4
