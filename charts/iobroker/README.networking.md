# Configure your network

For auto-discovery you will need to add a bit of more configuration.

In my case here, i will add a guide how to use [multus](https://github.com/k8snetworkplumbingwg/multus-cni) to attach additional interfaces to the ioBroker pod.
I do not intend to explain or utilize on how to use "host networking" or anything else, that is a huge issue in itself.

I will explain 2 scenarios

- `macvlan` simple macvlan to just expose the pod to the host network
- `ipvlan with VLAN` that adds your pod interface to the actual network and the underlying DHCP (Full l2 support)

If you are not sure what you need, please see [this guide](https://devopstales.github.io/kubernetes/multus/) - it's a good read.

## Macvlan
So to start with, install the `multus` CNI as and additional CNI to what ever you have right now.

Then deploy a macvlan NAD via CRD. You should most probably adjust

- `eth0` - your main interface might be something something else
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
      "cniVersion": "0.3.0",
      "type": "macvlan",
      "master": "eth0",
      "mode": "bridge",
      "ipam": {
        "type": "host-local",
        "subnet": "192.168.1.0/24",
        "rangeStart": "192.168.1.200",
        "rangeEnd": "192.168.1.216",
        "routes": [
          { "dst": "0.0.0.0/0" }
        ],
        "gateway": "192.168.1.1"
      }
    }'
```

Now, to add this network to you iobroker pod in this chart, just set

```yaml
networking:
  multus:
    attachment-definition-name: "iobroker-macvlan"
```

Alternatively you can go all manual by just setting the annotations

```yaml
deployment:
  annotations:
    "k8s.v1.cni.cncf.io/networks": "iobroker-macvlan"
```

If you want multiple / more interfaces and go beyond this, please see the [quickstart guide](https://github.com/k8snetworkplumbingwg/multus-cni/blob/master/docs/quickstart.md)


## Ipv
