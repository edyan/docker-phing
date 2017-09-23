FROM        alpine:3.6
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

# Prepare environment
RUN         addgroup -g 1000 phing
RUN         adduser -g "Phing" -H -u 1000 -D -G phing phing


# Install packages
RUN         apk update && \

            apk upgrade && \

            apk add ca-certificates graphviz php5-cli php5-dom php5-json php5-openssl php5-phar && \

            rm -rf /var/cache/apk/*


# Make PHP Available as "php"
RUN         ln -s /usr/bin/php5 /usr/bin/php


# Install composer
RUN         /usr/bin/php5 -r "copy('https://getcomposer.org/download/1.5.1/composer.phar', '/usr/local/bin/composer');" && \
            /usr/bin/php5 -r "if (hash_file('SHA384', '/usr/local/bin/composer') === 'fd3800adeff12dde28e9238d2bb82ba6f887bc6d718eee3e3a5d4f70685a236b9e96afd01aeb0dbab8ae6211caeb1cbe') {echo 'Composer installed';} else {echo 'Hash invalid for downloaded composer.phar'; exit(1);}" && \
            chmod 0755 /usr/local/bin/composer && \
            /usr/local/bin/composer selfupdate --stable


# Install phing and its dependencies with composer
RUN         mkdir -p /opt/composer
WORKDIR     /opt/composer
COPY        conf/composer.json /opt/composer/
RUN         /usr/local/bin/composer --prefer-dist --no-ansi --no-dev --no-progress update && \
            /usr/local/bin/composer clear-cache && \
            rm -rf /root/.composer

ENV         PATH       /opt/composer/vendor/bin:$PATH
ENV         PHING_UID  100
ENV         PHING_GID  101


# Copy and define the run.sh as the main command
COPY        run.sh     /run.sh
RUN         chmod +x    /run.sh

USER        phing
CMD         ["/run.sh"]
