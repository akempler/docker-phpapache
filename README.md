# Drupal PHP Apache

A PHP Apache image for Drupal development.


## Compose

```yml
  apache:
    depends_on:
      - mysql
    build: ./docker/apache
    volumes:
      - ../projects/drupal:/var/www/html
      - ./tmp/apache:/tmp
    links:
      - mysql
    ports:
      - "80:80"
    environment:
      DB_HOST: mysql:3306
      DRUPAL_VERSION: 8 # Allowed: 7, 8
      PHP_SENDMAIL_PATH: /usr/sbin/sendmail -t -i -S mailhog:1025
```

## Run

```sh
docker run -d -p 80:80 -v path/to/site:/var/www/html akempler/php-apache -v path/to/tmp:/tmp
For example:
docker run -d -p 80:80 -v ../projects/myproject:/var/www/html akempler/php-apache -v ./tmp/apache:/tmp