
# Composer

	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php
	php -r "unlink('composer-setup.php');"
	mv composer.phar /usr/local/bin/composer
	composer
	OR
	alias composer='php composer.phar'


	//composer require phpunit/phpunit
	composer require symfony/yaml:3.4.23

	php composer.phar require doctrine/mongodb-odm-bundle 3.0


	docker run -it --rm --name my-app \
	 -v "$PWD":/usr/src/myapp \
	 -w /usr/src/myapp \
	 php:5.6-cli-alpine3.8 sh

	docker run -it --rm --name my-app \
	 -v "$PWD":/usr/src/myapp \
	 -w /usr/src/myapp \
	 php:5.6-cli-alpine3.8 php your-script.php


<?php
require "vendor/autoload.php";

$input = file_get_contents("test.yaml");
$result = \Symfony\Component\Yaml\Yaml::parse($input);
var_dump($result);


