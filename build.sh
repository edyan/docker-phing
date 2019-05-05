#!/bin/bash

set -e

if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid Phing version to build as parameter"
    exit 1
fi

VERSION=$1
GREEN='\033[0;32m'
NC='\033[0m' # No Color
TAG=edyan/phing:${VERSION}

cd $1

echo "Building ${TAG}"
docker build -t ${TAG} .
if [[ "$VERSION" == "2.16" ]]; then
  echo ""
  echo "${TAG} will also be tagged 'latest'"
  docker tag ${TAG} edyan/phing:latest
fi

echo ""
echo ""
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build Done${NC}."
    echo ""
    echo "Run:"
    echo "  docker container run --rm --name phing${VERSION}-test-ctn ${TAG} phing -v"
    echo ""
    echo "To push that version (and other of the same repo):"
    echo "  docker push edyan/phing"
fi
