#!/bin/bash

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m \n'

print_result() {
  # print_result <component> <testresult> <moreinfo> <error_msg>
  printf "$1 check:"
  if [ "$2" == "0" ]; then 
    printf "$GREEN ok \033[0m($3) $NC"
  else
    printf "$RED nok $NC"
    test -n "$4" && echo "==> $4"
  fi
}

echo "checking environment"
echo "--------------------"

curl -s http://kubernetes.labs.acend.ch/ >/dev/null 2>/dev/null
RES=$?
print_result internet $RES "" "check connection or proxy config"

DOCKER=$(docker version --format '{{.Client.Version}}' 2>/dev/null)
RES=$?
VERSION=$(docker version -f {{.Client.Version}})
print_result docker $RES $VERSION "please install docker"

KUBE=$(kubectl version --short --client 2>/dev/null)
RES=$?
VERSION=$(echo $KUBE | awk '{print $3}')
print_result kubernetes $RES $VERSION "please install kubectl"

HELM=$(helm version --short --client 2>/dev/null)
RES=$?
VERSION=$(echo $HELM | sed -e "s/+/ /" | awk '{print $1}')
print_result helm $RES $VERSION "please install helm"

echo
echo "checking kubernetes"
echo "-------------------"

NODES=$(kubectl get nodes -o name 2>/dev/null)
RES=$?
print_result nodes $RES $(echo $NODES | wc -w) "check kubeconfig or permissions"

echo
exit 0
