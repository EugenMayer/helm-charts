# Configure your network

For auto-discovery you will need to add a bit of more configuration.

In my case here, i will add a guide how to use [multus](https://github.com/k8snetworkplumbingwg/multus-cni) to attach additional interfaces to the ioBroker pod.
I do not intend to explain or utilize on how to use "host networking" or anything else, that is a huge issue in itself.

I will explain 2 scenarios

- `macvlan` simple macvlan to just expose the pod to the host network
- `hostdevice` binds the host-nic directly into the pod
  If you are not sure what you need, please see [this guide](https://devopstales.github.io/kubernetes/multus/) - it's a good read.

## Macvlan

So to start with, install the `multus` CNI as and additional CNI to what ever you have right now.

Then deploy a macvlan NAD via CRD. You should most probably adjust

- `eth1` - your second interface on your node might be name something else
- `subnet/ranges/`
-

```yaml
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: iobroker-macvlan
spec:
  config: '{
    "name": "iobroker-macvlan",
    "cniVersion": "0.3.1",
    "type": "macvlan",
    "master": "eth1",
    "mode": "bridge",
    "ipam": {
    "type": "host-local",
    "subnet": "192.168.1.0/24",
    "rangeStart": "192.168.1.200",
    "rangeEnd": "192.168.1.216",
    "gateway": "192.168.1.1"
    }
    }'
```

Now, to add this network to you iobroker pod in this chart, just set

```yaml
workload:
  main:
    podSpec:
      annotations:
        k8s.v1.cni.cncf.io/networks: "iobroker-macvlan"
```

If you want multiple / more interfaces and go beyond this, please see the [quickstart guide](https://github.com/k8snetworkplumbingwg/multus-cni/blob/master/docs/quickstart.md)

## host device

This will use a host interface, usually a second interface you have on your node you want to dedicate to iobroker and
bind that one to the iobroker pod directly.

- be sure to use the address that was used on the host and use the right network.
- `240.0.0.0/4` is for multicast

```yaml
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: iobroker-host
spec:
  config: '{
            "name": "iot-iobroker-host",
            "cniVersion": "0.3.1",
            "type": "host-device",
	          "device": "eth1",
            "ipam": {
              	"type": "static",
                "addresses": [
                  {
                    "address": "192.168.1.10/24",
                    "gateway": "192.168.1.1"
                  }
                ],
                "routes": [ {"dst": "240.0.0.0/4"} ]
            }
          }'
```

Now, to add this network to you iobroker pod in this chart, just set

```yaml
workload:
  main:
    podSpec:
      annotations:
        k8s.v1.cni.cncf.io/networks: "iobroker-host"
```
