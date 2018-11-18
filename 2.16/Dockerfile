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
                    ca-certificates graphviz shadow \
                    php7-cli \
                    php7-ctype \
                    php7-curl \
                    php7-dom \
                    php7-json \
                    php7-mbstring \
                    php7-openssl \
                    php7-pdo_sqlite \
                    php7-phar \
                    php7-simplexml \
                    php7-tokenizer \
                    php7-xml \
                    php7-xmlwriter && \
            # clean
            rm -rf /var/cache/apk/*

# Install composer
COPY        composer.json /opt/composer/
RUN         cd /opt/composer && \
            php -r "copy('https://getcomposer.org/download/1.7.3/composer.phar', '/usr/bin/composer');" && \
            chmod 0755 /usr/bin/composer && \
            /usr/bin/composer selfupdate --no-ansi --stable && \
            # Install phing and its dependencies with composer
            /usr/bin/composer --no-ansi -o --prefer-dist --no-dev --no-progress --no-suggest update && \
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
