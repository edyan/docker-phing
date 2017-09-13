FROM debian:jessie-slim
MAINTAINER Emmanuel Dyan <emmanueldyan@gmail.com>

# Upgrade the system and Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates graphviz php5-cli && \

    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

# Install composer
RUN php -r "copy('https://getcomposer.org/download/1.5.1/composer.phar', '/usr/local/bin/composer');" && \
    php -r "if (hash_file('SHA384', '/usr/local/bin/composer') === 'fd3800adeff12dde28e9238d2bb82ba6f887bc6d718eee3e3a5d4f70685a236b9e96afd01aeb0dbab8ae6211caeb1cbe') {echo 'Composer installed';} else {echo 'Hash invalid for downloaded composer.phar'; exit(1);}" && \
    chmod 0755 /usr/local/bin/composer && \
    /usr/local/bin/composer selfupdate --stable

# Install phing and its dependencies with composer
RUN mkdir -p /opt/composer
COPY conf/composer.json /opt/composer/
RUN cd /opt/composer && \
    composer --no-ansi update --no-dev --no-progress
ENV PATH /opt/composer/vendor/bin:$PATH

# run the basic chown commands
COPY run.sh     /run.sh
RUN  chmod +x    /run.sh


CMD ["/run.sh"]
