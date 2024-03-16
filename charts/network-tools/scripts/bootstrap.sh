#!/bin/bash

set -e

apt update
apt install -y curl wget iperf3 inetutils-ping telnet dnsutils procps

echo "run iperf3 on port 5201"
exec iperf3 -s -p 5201
