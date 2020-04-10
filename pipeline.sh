#!/bin/bash

set -e

ORG="acend"
APP="construction"

# start
docker build -t $ORG/$APP .
bash -c "docker stop $APP; exit 0"
docker run -d --rm -p 8080:80 --name $APP $ORG/$APP

# test
curl --fail localhost:8080/

# stop
docker logs $APP
docker stop $APP

# push image
docker push $ORG/$APP

# cleanup
docker image prune --force

set +e

# deploy
kubectl --context cloud create ns acend
kubectl --context cloud -n acend apply -f acend.yaml
kubectl --context cloud -n acend rollout status deploy/acend-deploy

exit 0
