#!/bin/bash

set -e

if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid Phing version to build as parameter"
    exit 1
fi

VERSION=$1
GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd $1
docker build -t "phing${VERSION}_test" .
echo ""
echo ""
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build Done${NC}."
    echo ""
    echo "Run : "
    echo "  docker run -ti --env PHING_UID=$(id -u) --env PHING_GID=$(id -g) --rm --volume \$(pwd):\$(pwd) phing${VERSION}_test phing"
fi
