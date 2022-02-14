# WAT

Runs an Iperf3 server, by default exposed by an LoadBalancer service.

You usually run this chart temporary to measure and debug kubernetes network aspects and benchmark your throughput.

# Values

Check the `values.yaml` file

# Usage

Deploy the chart, set the externalIp to a ip on your control-plane and then run

```bash
iperf3 -c <controlPlaneIpOrFip> -p 5201
```
