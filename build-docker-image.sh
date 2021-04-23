#!/bin/bash
set -x

NAMESPACE="respectablewizard"
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
VERSION="2.0.23"
COMPONENT="docker-horizen-masternode"

function build {
  echo "Building $COMPONENT"
  docker build --build-arg VERSION=$VERSION -t $NAMESPACE/$COMPONENT -t $NAMESPACE/$COMPONENT:latest .
  # docker push $NAMESPACE/$COMPONENT
  # docker push $NAMESPACE/$COMPONENT:latest
}
build horizen $1
