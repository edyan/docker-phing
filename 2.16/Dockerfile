FROM        alpine:3.7
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

# Prepare environment
RUN         mkdir /opt
RUN         addgroup -g 1000 phing
RUN         adduser -h /opt/composer -s /bin/ash -g "Phing" -u 1000 -D -G phing phing


# Packages management
RUN         apk update && \
            apk upgrade && \
            # Install packages
            apk add --no-cache \
                    ca-certificates graphviz \
                    php5-cli php5-ctype php5-dom php5-json php5-openssl php5-phar php5-xml \
                    php5-pdo_sqlite shadow && \
            # clean
            rm -rf /var/cache/apk/*


# Make PHP Available as "php"
RUN         ln -s /usr/bin/php5 /usr/bin/php

# Install composer
COPY        composer.json /opt/composer/
RUN         cd /opt/composer && \
            php -r "copy('https://getcomposer.org/download/1.5.1/composer.phar', '/usr/bin/composer');" && \
            php -r "if (hash_file('SHA384', '/usr/bin/composer') === 'fd3800adeff12dde28e9238d2bb82ba6f887bc6d718eee3e3a5d4f70685a236b9e96afd01aeb0dbab8ae6211caeb1cbe') {echo 'Composer installed';} else {echo 'Hash invalid for downloaded composer.phar'; exit(1);}" && \
            chmod 0755 /usr/bin/composer && \
            /usr/bin/composer selfupdate --stable && \
            # Install phing and its dependencies with composer
            /usr/bin/composer --prefer-dist --no-dev --no-progress --no-suggest update && \
            rm -rf /usr/bin/composer /root/.composer && \
            rm -rf /opt/composer/vendor/*/*/tests /opt/composer/vendor/*/*/Tests && \
            rm -rf /opt/composer/vendor/*/*/doc /opt/composer/vendor/*/*/docs

COPY        tests/test.php /opt/composer/test.php
RUN         chmod -R go+rX /opt/composer

# Run environment variable, required files, etc.
ENV         PHING_UID  1000
ENV         PHING_GID  1000
ENV         PATH=$PATH:/opt/composer/vendor/bin

COPY        phing /usr/bin/phing
RUN         chmod 0755 /usr/bin/phing
CMD         ["/usr/bin/phing"]
