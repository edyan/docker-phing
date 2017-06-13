FROM debian:jessie
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

# Upgrade the system and Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates graphviz php5-cli && \

    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer && \
    php -r "unlink('composer-setup.php');"

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
