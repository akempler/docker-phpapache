FROM php:7.1.0-apache
# FROM php:5.6-apache

MAINTAINER Adam Kempler <akempler@gmail.com>

ENTRYPOINT ["/root/entrypoint.sh"]

RUN rm /bin/sh \
 && ln -s /bin/bash /bin/sh

# Fix permissions on Mac
RUN usermod -u 1000 www-data \
 && usermod -G staff www-data

RUN apt-get update \
  && apt-get install -y \
    libpng12-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev \
    libmcrypt-dev \
    vim \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip soap xmlrpc \
  && pecl install -o -f xdebug


RUN a2enmod rewrite \
  && a2enmod ssl \
  && a2enmod headers

ADD conf/apache/default.conf /etc/apache2/sites-available/000-default.conf
ADD conf/php/00_opcache.ini /usr/local/etc/php/conf.d/
ADD conf/php/00_xdebug.ini /usr/local/etc/php/conf.d/
ADD conf/php/php.ini /usr/local/etc/php/conf.d/


RUN a2ensite 000-default.conf


WORKDIR /var/www/html

# Add entrypoint
ADD entrypoint.sh /root
RUN chmod +x /root/entrypoint.sh
