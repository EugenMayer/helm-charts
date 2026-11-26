## 2.0.0

**BREAKING**: migrated to TrueCharts common 32.9.0 ("common 2026")

- Update vikunja from 2.6.0 to 2.8.0
- Update common from 29.10.4 to 32.9.0
- Drop the `valkey` helm sub-chart (aliased `redis`). Valkey is now provided by the common dependency system
  - `redis.enabled` is replaced by `dependencies.valkey.enabled` (default `true`)
  - the password is now set via `dependencies.valkey.depconfig.password` - **change the default `PLACEHOLDERPASSWORD`**
  - the service is now `<release>-vikunja-valkey-main:6379` (was `<release>-redis:6379`), the secret `<release>-valkeycreds` (was `<release>-rediscreds`)
  - valkey now runs on the TrueCharts containerforge valkey image as UID/GID 568 instead of root
  - the old `<release>-redis` StatefulSet is replaced; its data (cache / keyvalue only) is **not** migrated and its old PVC is left behind and can be deleted
  - when `dependencies.valkey.enabled: false`, cache/keyvalue/ratelimit fall back to vikunja's in-memory store instead of failing to render
- Migrate `cnpg.main.enabled: false` to `dependencies.postgresql.enabled: false` (the top-level `cnpg` key is no longer supported by common), the built-in PostgreSQL stays disabled - this chart keeps using an external database via `postgres:`
- Restore the `postgres:` defaults block in `values.yaml` (`host`, `port`, `database`, `username`, `password`, `sslmode`) which was lost in a previous sync and made rendering fail without user-supplied values
- `postgres.password` is rendered into the config secret when set (you can still use `VIKUNJA_DATABASE_PASSWORD` instead)
- Fix the JWT secret lookup: it looked for `<fullname>-storage-secret` while the secret is called `<fullname>-secret-storage`, so the JWT secret was regenerated on every upgrade (logging out all users)

## 1.3.1

- fix publicurl and frontendurl being set to nonsense values fooling the deployment. Do not set a default at all

## 1.3.1

- Update to 2.6.1

## 1.3.0

- Update to 2.6.0

## 1.3.0

- Migrate from redis to valkey

## 1.1.0

- Upgrade vekunja to 2.4.0

## 1.0.0

- Upgrade vekunja to 2.3

## 0.1.2

- Fix trimming port leading to typecast issue

## 0.1.1

- Move postgres and mail passwords to secrets

## 0.1.0

- First own release based on the upstream 17.2.0 app version
