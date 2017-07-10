#!/bin/bash

set -e

docker build -t "inet_phing_test" .
echo ""
echo ""

if [ $? -eq 0 ]; then
    echo -e "\x1b[1;32mBuild Done. To run it: \e[0m"
    echo 'docker run -it --rm inet_phing_test phing'
fi


