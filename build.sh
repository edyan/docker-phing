#!/bin/bash

set -e

docker build -t "phing_test" .
echo ""
echo ""
echo -e "\x1b[1;32mBuild Done. To run it: \e[0m"
echo 'docker run -it --rm phing_test phing'
