
# Get-Started
doskey composer=php ..\composer.phar $*
composer global require laravel/installer
OR
composer global require "laravel/installer=~2.1"
=> Windows: %USERPROFILE%\AppData\Roaming\Composer\vendor\bin

composer create-project laravel/laravel myapp 5.8.*
OR
composer create-project --prefer-dist laravel/laravel 5.8
OR
laravel new basic-crud

@php -r "file_exists('.env') || copy('.env.example', '.env');"

php artisan --version
//composer install?

vim ./vendor/laravel/framework/src/Illuminate/Foundation/Application.php
php artisan serve
OR
php artisan serve --port=8001

php artisan config:clear
php artisan env

.env
APP_ENV=development
APP_DEBUG=true
APP_ENV=local
APP_ENV=production

php artisan tinker
	factory(App\User::class, 200)->create();


# Installation

# Database

## Read & Write Connections
```
'mysql' => [
    'read' => [
        'host' => [
            '192.168.1.1',
            '196.168.1.2',
        ],
    ],
    'write' => [
        'host' => [
            '196.168.1.3',
         ],
    ],
    'sticky'    => true,
    'driver'    => 'mysql',
    ...
```

## Migration

Schema::drop();		instead of Schema::dropIfExists();

php artisan make:migration create_tasks_table --create="tasks"
php artisan make:migration add_reminder_to_tasks_table --table="tasks"

php artisan make:model Task
	// Model class properties: 'connection', 'relations', 'guarded', 'fillable', etc.

	public $table = 'tasks';
	protected $fillable = Array();			// Fields that should be fillable through mass assignment (create([...])).
	protected $guarded = Array('id', 'password'); // Array('*') to block all attributes from mass assignment.
	protected $hidden = Array('password', 'remember_token');		// The attributes excluded from the model's JSON form.

	$perPage
	$

	save()
	find()
	update()
	
php artisan tinker
	$task = new App\Task;
	$task->toArray();
	$task->save();



# Auth
https://laravel.com/docs/5.8/verification

https://itsolutionstuff.com/post/laravel-58-email-verification-exampleexample.html
php artisan make:auth

```outes/web.php
Route::get('/', function () {

    return view('welcome');

});
Auth::routes(['verify' => true]);

Route::get('/home', 'HomeController@index')->name('home');
```

https://appdividend.com/2018/09/11/laravel-5-7-email-verification-tutorial-example/

# Migration
php artisan migrate:make create_users_table

php artisan migrate --path=app/foo/migrations
php artisan migrate --package=vendor/package


php artisan make:migration add_completed_to_users

php artisan make:migration create_users_table --create=users
php artisan make:migration add_votes_to_users_table --table=users

php artisan migrate:rollback --step=2

php artisan make:model Settings --migration

php artisan make:model Profile

php artisan make:model ModelName -mc
php artisan make:model ModelName -mcr  (r: for resource methods)



# Model

php artisan make:model Customer
php artisan make:model Company

## Eloquent

### Model Event
11 events: 
    retrieved
    creating
    created
    updating
    updated
    saving
    saved
    deleting
    deleted
    restoring
    restored.



# Seed
php artisan make:seeder UserTableSeeder
php ..\composer.phar dump-autoload
vim database/seeds/UserTableSeeder.php
php artisan db:seed --class=UserTableSeeder



php artisan clear-compiled
composer dump-autoload
php artisan optimize



# Mail
php artisan make:mail OrderShipped



# Statamic



# Schedule

php artisan schedule:run
	https://www.digitalocean.com/community/tutorials/how-to-deploy-an-advanced-php-application-using-ansible-on-ubuntu-14-04

# Auto-deploy
https://github.com/ptibbetts/anstead
https://github.com/lasselehtinen/barn

>>>>>>> 2837622cc7802133b2e3eb78951215ad9f0971e2


# MISC

<<<<<<< HEAD
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
php vendor/bin/phpDocumentor.phar -d {蟇ｾ雎｡繝�繧｣繝ｬ繧ｯ繝医Μ繝ｼ縺ｮ繝代せ} -t {繝峨く繝･繝｡繝ｳ繝育函謌仙�医�ｮ繝代せ}
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


=======
Rename branch
git branch -m master develop    # rename master on local
git push origin :master         # delete master on remote
git push origin develop         # create develop on remote
git checkout -b master develop  # create a new local master on top of develop
git push origin master          # create master on remote




php artisan route:clear

composer dump-autoload

php artisan route:list

php artisan config:cache
php artisan cache:clear
php artisan config:clear


artisan optimize


       // DEBUG
        //return redirect('home')->with('error','You have not admin access');

        var_dump(auth()->user());
        abort(404, 'Page not found');

https://laracasts.com/discuss/channels/laravel/update-user-account


https://learnku.com/docs/the-laravel-way/5.6/Tao-5-6/2947
https://github.com/fideloper/TrustedProxy
https://laravel.com/docs/5.8/requests


php artisan route:list


public function logout(Request $request)

{

     Auth::guard('authority')->logout();

     $request->session()->flush();

     $request->session()->regenerate();

     return redirect()->guest(route('authority.login'));
}


		header("Content-Type: text/plain");
		$isCustomer = $current_user->groups()->where('group_keyword', 'customer')->first() !== NULL;
		var_dump( $xxx );
		exit(1);
		dd($current_user);

## DB Transaction

https://fideloper.com/laravel-database-transactions

## Breadcrumbs
https://medium.com/@radicalloop/database-transactions-in-laravel-daa1b9751872

## Payment
https://medium.com/@firdaushishamuddin/building-e-commerce-application-with-laravel-5-8-and-billplz-payment-7d8023de8111?source=post_recirc---------1------------------


##  Differences between “php artisan dump-autoload” and “composer dump-autoload

Following below some difference between "php artisan dump-autoload” and “composer dump-autoload”

Laravel's Autoload is a bit different:


Composer dump-autoload

    PATH vendor/composer/autoload_classmap.php
    Composer dump-autoload won’t download a thing.
    It just regenerates the list of all classes that need to be included in the project (autoload_classmap.php).
    Ideal for when you have a new class inside your project.
    autoload_classmap.php also includes the providers in config/app.php

PHP artisan dump-autoload

    It will call the Composer with the optimize flag
    It will 'recompile' loads of files creating the huge bootstrap/compiled.php




php artisan storage:link

# Routes

Route::get('users', ['uses'=>'UserController@index', 'as'=>'users.index']);
{{ route('users.index') }}

## Redirect

if(Auth::attempt(Input::get('data')))
Redirect::intended();


if ($request->isMethod('post')) {




# Datatables

$ composer require yajra/laravel-datatables-oracle:"~9.0"

Service Provider & Facade (Optional on Laravel 5.5)

Register provider and facade on your config/app.php file.

'providers' => [
    ...,
    Yajra\DataTables\DataTablesServiceProvider::class,
]

'aliases' => [
    ...,
    'DataTables' => Yajra\DataTables\Facades\DataTables::class,
]

Configuration (Optional)

$ php artisan vendor:publish --provider="Yajra\DataTables\DataTablesServiceProvider"


# TO-TRY
			return redirect()->route('demo.index');
			Session::flash('success_message', 'Biography was updated! However, because this is a demo the records are not persisted to the database.');

	https://laraveldaily.com/how-to-change-date-format-in-laravel-and-jquery-ui-datepicker/
		$('.date').datepicker({
		    format: '{{ config('app.date_format_js') }}'
		});


			$('#event_date').datepicker({

			    autoclose: true,

			    startDate: today,

			    format: 'mm/dd/yyyy',

			    daysOfWeekDisabled: "6,0",

			    language: "en"

			}).on('changeDate', function(e) {

			    console.log(e.format());

			});	


				$('input').datepicker({

				    beforeShowDay: function(date){

				        var string = jQuery.datepicker.formatDate('yy-mm-dd', date);

				        return [ disabledDates.indexOf(string) == -1 ]

				    }

				});

	https://laracasts.com/discuss/channels/laravel/laravel-mailable-not-working?page=1
		Mailing





(function($) {
    $.fn.toggleDisabled = function(){
        return this.each(function(){
            this.disabled = !this.disabled;
        });
    };
})(jQuery);

Then use it like this:

$('#my-select').toggleDisabled();


# Debugging

// For debugging only
Route::get('test001', function () {

	$a = \App\Cust_Application::all()->first();


	$commencement_date = \Illuminate\Support\Carbon::createFromFormat('Y-m-d', $a->commencement_date); // MySQL datetime format to Carbon object


	dd( $commencement_date->add(-3, 'day')->format('d/m/Y') );
});


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


# TODO

- Behat/Behat
- https://github.com/orchestral/testbench
  パッケージでテストを書けるようにするには、Orchestral Testbenchパッケージを使用してください。
- CMS
	- OctoberCMS
	- https://asgardcms.com/
	- http://www.lavalite.org/
	- https://www.laravelcms.tech/
	- https://www.laracms.cn/
	- https://laravel-cms.com/
		- Laravel Nova
		- Laravel Forge
