#!/bin/bash
set -x

NAMESPACE="respectablewizard"
DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

function build {
  COMPONENT=$1
  VERSION=$2
  echo "Building $COMPONENT"
  docker build --build-arg VERSION=$VERSION -t $NAMESPACE/$COMPONENT -t $NAMESPACE/$COMPONENT:latest .
  # docker push $NAMESPACE/$COMPONENT
  # docker push $NAMESPACE/$COMPONENT:latest
}
build horizen $1