# WAT

Chart to host a NIST data mirror - see https://github.com/EugenMayer/nist-data-mirror
It syncs and serves the NVD (CPE/CVE JSON) data from NIST.

When the container/pod starts intially, it should instanly preseed the data once (and not wait for the cron job)

# Volumes / PVC

Considering this a pure mirror image (somewhat cache-like), and it takes about 25s to compute and download the entire data, I decided to not include a PVC. If you think differently, be free to discuss this in a PR / issue.

## Refresh data

The data is refreshed every night using a cron-job. If you want to do it manually, you connect to the container and run

```bash
/usr/local/bin/mirror.sh
```

# Values

Check the `values.yaml` file

