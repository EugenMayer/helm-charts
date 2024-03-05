release-all: package-all
	cr upload --push --skip-existing 
	cr index --push 

package-all:
	cr package charts/postgres-pgdump-backup
	cr package charts/iperf3
	cr package charts/rundeck
	cr package charts/openldap-test
	cr package charts/vulnz-nvd-mirror
	cr package charts/cert-manager-cloudflare-config
	cr package charts/localpath
	cr package charts/whatsmyip
	cr package charts/coredns-private-dns-fix
	cr package charts/longhorn-backup-config
	cr package charts/iobroker