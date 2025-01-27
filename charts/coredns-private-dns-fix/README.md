# WAT

CoreDNS has an "interesting" default behavior which is not expected in the linux world.

**Linux way / expected**
When 2 DNS servers are presented via the resolv.conf / DNS tree, we would expect it to pick
the first one in order and try resolving. Then, if that fails (the server is not reachable) it would
try to pick the second one. https://linux.die.net/man/5/resolv.conf

> if there are multiple servers, the resolver library queries them in the order listed.

**CoreDNS way**
Instead of doing it as expected above, CoreDNS picks "one of the servers" round-robbing/random style.
It load balances through the servers, equally distributed. https://coredns.io/plugins/forward/

> TO… are the destination endpoints to forward to. The TO syntax allows you to specify a protocol, tls://9.9.9.9 or dns:// (or no protocol) for plain DNS. The number of upstreams is limited to 15.
Multiple upstreams are randomized (see policy) on first use. When a healthy proxy returns an error during the exchange the next upstream in the list is tried.

> policy specifies the policy to use for selecting upstream servers. The default is random.
random is a policy that implements random upstream selection.

Especially if the first server is a private / internal DNS and the second one is the typical "8.8.8.8" upstream
public dns for fallback, the above leads to issues.

Every second time we cannot resolve our private dns entries.

This chart fixes this by using a coredns override and lets coredns work sequential - as in linux. See https://k3d.io/v5.3.0/usage/k3s/#modifications

## Works for

- k3s
- rke2

## Install

```bash
helm repo add eugenmayer https://eugenmayer.github.io/helm-charts/
helm install eugenmayer/coredns-private-dns-fix
```

## More

See https://github.com/k3s-io/k3s/discussions/7822#discussioncomment-6307840
