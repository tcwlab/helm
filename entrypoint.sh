#!/usr/bin/env bash
set -eo pipefail

if [ -n "${KUBE_CONFIG_B64}" ]; then
	echo -n "${KUBE_CONFIG_B64}" | base64 -d >/home/helmusr/.kube/config
	chmod 600 /home/helmusr/.kube/config
fi

if [ ! -f /home/helmusr/.kube/config ]; then
	echo "Please mount your kubeconfig file to /.kube or pass it as base64 to environment variable KUBE_CONFIG_B64"
	exit 1
else
	exec "$@"
fi
