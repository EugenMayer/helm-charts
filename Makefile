.PHONY: release-all package-all

release-all: package-all
	cr upload --push --skip-existing 
	cr index --push 

package-all:
	cr package charts/cert-manager-certificate
	cr package charts/cert-manager-cloudflare-config
	cr package charts/cert-manager-external-account-bindings-cloudflare-config
	cr package charts/coredns-private-dns-fix
	cr package charts/euro-office-simple
	cr package charts/gradle-build-cache
	cr package charts/iperf3
	cr package charts/localpath
	cr package charts/longhorn-backup-config
	cr package charts/network-tools
	cr package charts/openldap-test
	cr package charts/postgres-pgdump-backup
	cr package charts/rundeck
	cr package charts/snyk-farcaster-agent
	cr package charts/traefik-default-middlewares
	cr package charts/traefik-default-trusted-proxy-ips
	cr package charts/vikunja
	cr package charts/whatsmyip
	cr package charts/whoami
	cr package charts/whoami-tls
