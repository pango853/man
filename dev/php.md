
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


# gettext

Pure PHP:
```php
<?php
// 日本-日本語にロケールをセットして
setlocale(LC_ALL, 'ja_JP'); 
// 翻訳カタログが入ったmessage.moファイルのエンコードをUTF-8と宣言して
bind_textdomain_codeset('message', 'UTF-8');
// message.moのディレクトリを指定して
bindtextdomain('message', dirname(__FILE__));
// gettext()がコールされた際に、message.moからカタログを検索するようにして
textdomain('message');
// 翻訳言語を出す
echo gettext('hoge');

```

PEAR File_Gettextを使ったサンプル:
```php
<?php
require_once 'File/Gettext.php';

function __($str)
{
    static $mo;
    
    if (is_null($mo)){
        $mo = File_Gettext::factory('MO');
        $mo->load('locale/ja_JP/LC_MESSAGES/message.mo');
    }
    
    $catalog = $mo->toArray();
    if (isset($catalog['strings'][$str])){
        return $catalog['strings'][$str];
    }
    return $str;
}


echo __('email');
```

Other libraries.

- php-gettext: https://launchpad.net/php-gettext/
- PEARのFile_Gettext: http://pear.php.net/package/File_Gettext
- oscarotero/Gettext: https://github.com/oscarotero/Gettext



# New Features Highlight

## 7.4

```php
<?php

class User {
  public int $age; // 限定屬性類型
  public string $name;
}
$user->age = "XXX"; // Error!

```

```php
<?php

$nums = array_map(fn($n)=>$n * $n, [1,2,3]); // fn()=> : Simular to E6 syntax
$nums = array_map(function($num)use($factor){ return $num * $num; }, [1,2,3])
```

```php
<?php

class A {}
class B extends A {}

class Producer {
    public function method(): A {}
}
class BProducer extends Producer {
    public function method(): B {}
}
```

```php
<?php

$parts = ['apple', 'pear'];
$fruits = ['banana', 'orange', ...$parts, 'watermelon']; // ...
// Old way: array_merge(['banana', 'orange'], $parts, ['watermelon']);
```

```php
<?php

$array['key'] ??= computeDefault(); // For setting default value
// Old way: if (!isset($array['key'])) $array['key'] = computeDefault();
```

```php
<?php

299_792_458;   // Underscores in digits
6.674_083e-11; // float also OK
0xCAFE_F00D;   // hexadecimal
0b0101_1111;   // binary
```

__toString() can throw exception now!

```php
<?php

filter_var(1.00, FILTER_VALIDATE_FLOAT); // FILTER_VALIDATE_FLOAT added for filter
```


```php
<?php

strip_tags($str,['p','a','div']); // Now support array directly
// Old way: strip_tags($str, "<p><a><div>");
```

### Deprecated

```
<?php

1 ? 2 : 3 ? 4 : 5;   // deprecated
(1 ? 2 : 3) ? 4 : 5; // ok
1 ? 2 : (3 ? 4 : 5); // ok

$arr = ["a"=>"111"];
$arr{$index}; // deprecated finally!
$arr[$index]; // OK
```

money_format deprecated -> use numberFormater instead

Removed extensions:
- Firebird/Interbase
- Recode
- WDDX


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