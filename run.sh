#!/bin/sh
sed -i "s/:100:101:phing:/:$PHING_UID:$PHING_GID:phing:/g" /etc/passwd
sed -i "s/:101:phing/:$PHING_GID:phing/g" /etc/group
