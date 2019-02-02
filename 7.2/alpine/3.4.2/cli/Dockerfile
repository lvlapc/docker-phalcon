FROM php:7.2-cli-alpine

ENV PHALCON_VERSION=3.4.2

RUN set -xe && \
\
	#Manually installing build deps
	apk add --update --no-cache --virtual .build-deps $PHPIZE_DEPS \
\
	#Installing Phalcon
	&& wget https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz -O - | tar -zx -C /tmp/ \
	&& docker-php-ext-install -j$(nproc) /tmp/cphalcon-${PHALCON_VERSION}/build/php7/64bits \
\
	#Dependencies for extensions
	&& apk add --update --no-cache \
	#for intl
	icu-dev \
	#for gettext
	gettext-dev \
	#for gd
	libjpeg-turbo-dev libpng-dev freetype-dev \
	#for postgres
	postgresql-dev \
\
	#Installing extensions
	&& docker-php-ext-install intl \
	&& docker-php-ext-install gettext \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install pdo_pgsql \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	#... from pecl
	&& pecl install redis \
	&& pecl install xdebug \
	&& docker-php-ext-enable redis xdebug \
\
	#Cleaning up
	&& apk del .build-deps && rm -rf /tmp/* \
\
	#Config
	&& mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY docker-phalcon-* /usr/local/bin/