release-all:
	cr upload --skip-existing
	cr index

package-all:
	cr package charts/postgres-pgdump-backup
	cr package charts/iperf3
	cr package charts/rundeck

release-gh:
	cr index
