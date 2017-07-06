# iNet Process PHP FPM Docker Image
Docker Hub: https://hub.docker.com/r/edyan/phing

Docker containers that contains [phing](https://www.phing.info/), a build tool for PHP Applications. It's made for development purposes.

To use it in an integrated environment, try our [Docker LAMP stack](https://github.com/inetprocess/docker-lamp)


# Run your phing command
## From outside
```bash
docker run -it --rm --name phing-ctn --volume /var/www/myapp:/myapp inetprocess/phing phing -f /myapp/build.xml
```

## By entering the container
```bash
docker run -it --rm --name phing-ctn --volume /var/www/myapp:/myapp inetprocess/phing bash

# Once inside the container
cd /myapp
phing
```
