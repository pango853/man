
# Get-Started
doskey composer=php ..\composer.phar $*
composer global require "laravel/installer=~2.1"
composer create-project laravel/laravel myapp 5.8.*

@php -r "file_exists('.env') || copy('.env.example', '.env');"

php artisan --version
vim ./vendor/laravel/framework/src/Illuminate/Foundation/Application.php
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



# MISC

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


##  Differences between gphp artisan dump-autoloadh and gcomposer dump-autoload

Following below some difference between "php artisan dump-autoloadh and gcomposer dump-autoloadh

Laravel's Autoload is a bit different:


Composer dump-autoload

    PATH vendor/composer/autoload_classmap.php
    Composer dump-autoload wonft download a thing.
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
