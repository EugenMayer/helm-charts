# WAT

Chart to host a NIST data mirror - see https://github.com/EugenMayer/nist-data-mirror
It syncs and serves the NVD (CPE/CVE JSON) data from NIST.

# Volumes / PVC

Considering this a pure mirror image, and it takes about 25s to compute and download the entire data, I decided to not
include and PVC. If you think differently, be free to discuss this in a PR / issue.

# Values

Check the `values.yaml` file

