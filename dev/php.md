
# I/O

```php
#!/usr/bin/env php 
<?php
	$input = file_get_contents('php://stdin');
	$pattern = '/([a-z])([A-Z])/e';
	$replace = "'${1}_' . strtolower('${2}')";
	echo preg_replace($pattern, $replace, $input);
```

```camel_to_snake.php
PREG_REPLACE_EVAL is now deprecated so use preg_replace_callback instead

function camel_to_snake ( $input )
{
	if ( preg_match ( '/[A-Z]/', $input ) === 0 ) { return $input; }
	$pattern = '/([a-z])([A-Z])/';
	$r = strtolower ( preg_replace_callback ( $pattern, function ($a) {
		return $a[1] . "_" . strtolower ( $a[2] ); 
	}, $input ) );
	return $r;
}

echo camel_to_snake ( file_get_contents('php://stdin') );
```

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


# Coding Conventions

## Comment

- https://www.php.net/manual/en/language.basic-syntax.comments.php
- https://en.wikibooks.org/wiki/PHP_Programming/Commenting_and_Style

- https://pear.php.net/manual/en/standards.sample.php
- https://pear.php.net/manual/en/standards.header.php
- https://docs.phpdoc.org/guides/docblocks.html


```
class Foo {

	/**
	 * @var array $bar: Description here
	 * @example [ 'foo' => Bar, 'quux' => Bar, .. ]
	 */
	protected $bar;

	/**
	 * Description here, following by documentation of the parameters.
	 *
	 * Some example:
	 * @code
	 * ...
	 * @endcode
	 *
	 * @since 1.24
	 * @param FooContext $context context for decoding Foos
	 * @param array|string $options Optionally pass extra options. Either a string
	 *  or an array of strings.
	 * @return Foo|null New instance of Foo or null of quuxification failed.
	 */
	public function makeQuuxificatedFoo( FooContext $context = null, $options = [] ) {
		/* .. */
	}

}

```

File level: 
@file
@ingroup
@author
Class, class member, or global member: 
@todo
@var
@deprecated
@class
@see
@since
@param
@return
@throws
@private

Test:
@depends
@group
@covers
@dataProvider
@expectedException
@expectedExceptionMessage