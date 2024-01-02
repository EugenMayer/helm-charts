# WAT

CoreDNS has an "interesting" default behavior which is not expected in the linux world.

**Linux way / expected**
When 2 DNS servers are presented via the resolv.conf / DNS tree, we would expect it to pick
the first one in order and try resolving. Then, if that fails (the server is not reachable) it would
try to pick the second one. https://linux.die.net/man/5/resolv.conf

**CoreDNS way**
Instead of doing it as expected above, CoreDNS picks "one of the servers" round-robbing style.
It load balances though the servers, equally distributed. https://coredns.io/plugins/forward/

Especially if the first server is a private / internal DNS and the second one is the typical "8.8.8.8" upstream
public dns for fallback, the above leads to issues.

Every second time we cannot resolve our private dns entries.

This chart fixes this by using a coredns override 

## More

See https://github.com/k3s-io/k3s/discussions/7822#discussioncomment-6307840
