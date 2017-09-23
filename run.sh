#!/bin/sh
sed -i "s/:1000:1000:Phing:/:$PHING_UID:$PHING_GID:phing:/g" /etc/passwd
sed -i "s/:1000:phing/:$PHING_GID:phing/g" /etc/group
