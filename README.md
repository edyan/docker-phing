# Phing docker image
Docker Hub: https://hub.docker.com/r/edyan/phing

Docker containers that contains [phing](https://www.phing.info/), a build tool for PHP Applications. It's made for development purposes.

To use it in an integrated environment, try [Stakkr](https://github.com/edyan/stakkr)

That image is built with alpine (❤ ... Mb instead of 96Mb with debian-slim).

# Run your phing command
## From outside
```bash
docker run -it --rm --name phing-ctn --volume /var/www/myapp:/myapp edyan/phing:2.16 phing -f /myapp/build.xml
```

## By entering the container
```bash
docker run -it --rm --name phing-ctn --volume /var/www/myapp:/myapp edyan/phing bash

# Once inside the container
cd /myapp
phing
```
