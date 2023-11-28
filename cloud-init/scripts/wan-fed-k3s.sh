#!/bin/bash

multipass info k3s-au &> /dev/null || multipass launch -n k3s-au -m 4G -c 2 --cloud-init ../k3s.yaml
multipass info k3s-us &> /dev/null || multipass launch -n k3s-us -m 4G -c 2 --cloud-init ../k3s.yaml

multipass exec k3s-au helm repo add hashicorp https://helm.releases.hashicorp.com
multipass exec k3s-us helm repo add hashicorp https://helm.releases.hashicorp.com

multipass transfer k3s-au.yaml k3s-au:
export SECONDARY_IP=$(multipass info k3s-us --format json | jq -r '.info[].ipv4[0]')
envsubst < k3s-us.yaml | multipass transfer - k3s-us:k3s-us.yaml

multipass exec k3s-au -- consul-k8s status || multipass exec k3s-au -- consul-k8s install -config-file k3s-au.yaml -auto-approve


multipass exec k3s-au -- sh -c 'kubectl --kubeconfig /home/ubuntu/.kube/config -n consul get secret consul-federation --output yaml > consul-federation-secret.yaml'

multipass transfer k3s-au:consul-federation-secret.yaml - | multipass transfer - k3s-us:consul-federation-secret.yaml

multipass exec k3s-us -- kubectl --kubeconfig /home/ubuntu/.kube/config create ns consul
multipass exec k3s-us -- kubectl --kubeconfig /home/ubuntu/.kube/config -n consul get secrets consul-federation || multipass exec k3s-us -- kubectl --kubeconfig /home/ubuntu/.kube/config apply -n consul -f consul-federation-secret.yaml



multipass exec k3s-us -- consul-k8s status || multipass exec k3s-us -- consul-k8s install -config-file k3s-us.yaml -auto-approve

open https://$(multipass info k3s-au --format json | jq -r '.info[].ipv4[0]'):9501
open https://$(multipass info k3s-us --format json | jq -r '.info[].ipv4[0]'):9501


