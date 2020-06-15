
DOSKEY composer=php ..\composer.phar $*


composer global require laravel/installer
=> Windows: %USERPROFILE%\AppData\Roaming\Composer\vendor\bin

composer create-project --prefer-dist laravel/laravel 5.8
OR
laravel new basic-crud

composer install

php artisan serve


# Patterns

- Services
- Service Provider
- Facades				https://laravel.com/docs/5.8/facades
- /bootstrap/app.php
- use App\Repositories\UserRepository


- namespace App\Http\Requests; use Illuminate\Foundation\Http\FormRequest;

- event listeners
- middleware
- queued jobs










# MISC

## Composer
> composer global why symfony/console

## Documentation
- Sami
  > composer require sami/sami dev-master
  OR
  > curl -O http://get.sensiolabs.org/sami.phar
  > php vendor\bin\sami.phar update config\sami.php
- Laravel API Documentation Generator (mpociot/laravel-apidoc-generator)
- swagger-php & Swagger UI
- https://www.phpdoc.org/templates
- phpDocumentor (http://phpdox.de/)


composer require mpociot/laravel-apidoc-generator
php artisan api:generate --routePrefix="api/*"
php artisan apidoc:generate
php artisan vendor:publish --provider="Mpociot\ApiDoc\ApiDocGeneratorServiceProvider" --tag=apidoc-config

composer require --dev phpdocumentor/phpdocumentor
OR
wget http://phpdoc.org/phpDocumentor.phar
SET PATH=%PATH%D:\DEV\graphviz\bin
php vendor/bin/phpDocumentor.phar -d {対象ディレクトリーのパス} -t {ドキュメント生成先のパス}
php vendor/bin/phpDocumentor.phar -f app/User.php -t public/phpdoc


## Extra
- Laravel IDE Helper Generator (https://github.com/Barryvdh/laravel-ide-helper)
  - require "barryvdh/laravel-ide-helper": "1.*"
  - Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider
  - php artisan ide-helper:generate
- Documenting API with swagger (http://zircote.com/swagger-php/annotations.html + https://github.com/swagger-api/swagger-ui)

## Debug

Tinker:

	DB::listen(function ($query) { dump($query->sql); dump($query->bindings); dump($query->time); });
 
To log database queries, 
```app/Providers/AppServiceProvider.php boot() method:
namespace App\Providers;

use DB;
use Log;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        DB::listen(function($query) {
            Log::debug(
                $query->sql,
                $query->bindings,
                $query->time
            );
        });
    }

    // ...
}
```


# Composer

```
 composer.json

{
    "scripts":{
            "post-update-cmd":[
                    "php artisan ide-helper:generate",
                    "php artisan optimize",
            ]
    },
}
```

# Testing

```
public function testBasicExample()
{
    Cache::shouldReceive('get')
         ->with('key')
         ->andReturn('value');

    $this->visit('/cache')
         ->see('value');
}
```

# "Learning Laravel's Eloquent"						10/202
KW:
- Setup
  - composer
    > php -r "readfile('https://getcomposer.org/installer');" | php
	> composer create-project laravel/laravel my_project
	> composer dump-autoload
  - Homestead
	> vagrant box add laravel/homestead
	OR
	> composer global require "laravel/homestead=~2.0"
	> homestead init
	config...
	> headstead up
	> headstead ssh
	OR
	> git clone https://github.com/laravel/homestead.git HomesteadFolder
	> bash init.sh
	OR even
	> git clone https://github.com/Swader/homestead_improved.git MyHomesteadImprovedVM
	> vagrant up	
  - Adminer
    http://www.adminer.org/ 
  - Laravel 
    > composer global require "laravel/installer=~2.1"
	> composer create-project laravel/laravel ProjectName
- Building
  - Schema::create('users', function(Blueprint $table){ $table->increments('id'); $table->timestamps(); });
  - Schema::rename($previousName, $newName);
  - Schema::drop($tableName); OR Schema::dropIfExists($tableName);
  - if (Schema::hasTable('books')) {}
  - if (Schema::hasColumn('books', 'title')) {}

- Model
  - CRUD
  - where, aggregates and others
  - Mass assignment
  - Query scopes
  - Attributes casting, accessors and mutators
  - Big file
  - Imaginary attributes
  - Route model binding
  - Records chunking for memory optimzation
- Relationships
  - 1to1, 1toM, MtoM
  - inverses
  ...
- Collections
  - ...
- Events and Observers
  - ...
- Standalone Eloquent
  - ...
- Extending
  - Aweloquent
  - Repository pattern


# Visual Code

Install laravel-ide-helper

> composer require --dev barryvdh/laravel-ide-helper

Add this conditional statement in your AppServiceProvider to register the helper class.

```AppServiceProvider.php
public function register()
{
    if ($this->app->environment() !== 'production') {
        $this->app->register(\Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider::class);
    }
    // ...
}
```

> php artisan ide-helper:generate
to generate a file to help the IDE understand Facades. You will need to restart Visual Studio Code.

# Methods

public_path('upload/itsolutionstuff.com')
File::isDirectory($path)
File::makeDirectory($path, 0777, true, true)
DB::table('m_test')->select('main')->distinct()->orderBy('main', 'asc')->get();

# References

https://www.itsolutionstuff.com/category/laravelexample.html?page=4


# TO-Learn

## Faker: https://laravel-news.com/eloquent-eager-loading


# To-Use

## Lazy Eager Loading
	->load()


