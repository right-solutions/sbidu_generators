# Sbidu Generators

Use the generators provided by Sbidu to create sbidu applications fast.

## Create a Rails App

In order to use the generator you need to first create a blank rails application to run this generator

```sh
rails new demo-site.com -T -d mysql --skip-bundle
cd demo-site.com
```
### Add sbidu_generators to Gemfile

Add this line to your application's Gemfile:

```ruby
gem 'sbidu_generators'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install sbidu_generators
```

## Setup Generator

### Run the generator script for setup

This will add necessary files like .gitignore, Dockerfile, docker-compose.yml, database.yml template etc to the current project 

The only argument it requires is the application name.

```sh
$ rails g sbidu_generators:setup demo-site.com
```

It will also mount the required engines (pattana, usman & dhatu) to the config/routes.rb

```ruby
Rails.application.routes.draw do
  mount Pattana::Engine => "/"
  mount Usman::Engine => "/"
  mount Dhatu::Engine => "/"
end
```

Do bundle again as the above command had changed the Gemfile.
You might want to delete Gemfile.lock if you run into errors like compatible issues
```bash
$ rm Gemfile.lock
$ bundle
```

### Create Database, Copy and Run Migrations

```ruby
rails railties:install:migrations
rails db:create db:migrate
rails db:migrate RAILS_ENV=test
```

### Import Data

```ruby
bundle exec rails import:data:all
```

You can also insert some dummy data (seed data) if you want.

```ruby
bundle exec rails import:data:dummy:all
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

# Setup.sh

Alternatevely you could make use of the shell script to run all these and create a rails application ready to launch with minimal template.

You need to download the setup.sh from this repository to your working directory

Then make it executable

```ruby
$ chmod +x setup.sh
```

Run the script to create a sbidu rails app where app_name.com is the domain name (a convention followed at sbidu)

```ruby
$ ./setup.sh app_name.com
```

Go to the app directory

```ruby
$ cd app_name.com
```

Run the generator to copy all website related scripts

```ruby
$ rails g sbidu_generators:website app_name.com
```

