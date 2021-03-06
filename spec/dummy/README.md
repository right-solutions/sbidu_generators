# Sbidu Generators - To Be Changed
# APPNAME - README

This document contains basic instructions to setup the project locally and start developing it. 

Also check for the deployment instructions.

## Ruby Version

2.4.1

## System dependencies

This project requies 4 gems

kuppayam
pattana
usman &
dhatu

Most of the functionalities are in dhatu

## Configuration

Create a database.yml in config folder and it should have somthing like below:

development:
  adapter: mysql2
  encoding: utf8
  database: redvelvet_development
  username: <username>
  password: <password>
  port: 3306
  host: localhost

test:
  adapter: mysql2
  encoding: utf8
  database: redvelvet_test
  username: <username>
  password: <password>
  port: 3306
  host: localhost

## Bundle Install

```bash
$ bundle install
```

This will download all required gems so that we can run this project locally.

## Database creation

```bash
$ bundle exec rails db:create
```

This will create the test and development databases

```bash
$ bundle exec rails db:migrate RAILS_ENV=test
$ bundle exec rails db:migrate
```
This will run the migration for both development and test environment.

## How to run the test suite

```bash
$ bundle exec rspec db:migrate RAILS_ENV=test
```

# run rspec from the rails root folder and not from dummy folder as spec helper has been linked to dummy.
rspec 

## Master Data

We need to setup some master data for this proejct to run.
For e.g: Features, Roles, City, Country etc

```bash
$ bundle exec rake pattana:import:master_data:all verbose=false
$ bundle exec rake usman:import:master_data:all verbose=false
$ bundle exec rake dhatu:import:master_data:all verbose=false
```

You can over ride the contents (.csv files) by creating
db/master_data/<item>.csv

## Real Data

*What does it mean by Real Data ?*

Real Data means, the data which you would like to push to server. You can write the data in csv and place it in db/data and push to server. Run the rake task on server to import it and these data will go live.

Real Data could be different for different projects where as Master Data is mostly Same.

An easy way to import data is to try the following

```bash
$ bundle exec rake import:data:all verbose=false
```

This rake task which will invoke all other rake tasks required.

Alternatevely you can also try it individually.

```bash
$ bundle exec rake usman:import:data:all verbose=false
$ bundle exec rake dhatu:import:data:all verbose=false
```

You could also do it individually but the above command will run in the following order - users, features, permissions, roles. This order is important as features need users to be imported first.

```bash
$ bundle exec rake usman:import:data:users verbose=false
$ bundle exec rake usman:import:data:features verbose=false
$ bundle exec rake usman:import:data:permissions verbose=false
$ bundle exec rake usman:import:data:roles verbose=false

$ bundle exec rake dhatu:import:data:services verbose=false
$ bundle exec rake dhatu:import:data:sections verbose=false
$ bundle exec rake dhatu:import:data:products verbose=false
```

## Dummy Data

Most of the times, you would need dummy data to start developing the feature or fix bugs.

An easy way to import data is to try the following

```bash
$ bundle exec rake import:data:all verbose=false
```

This rake task which will invoke all other rake tasks required.

Alternatevely you can also try it individually.


```bash
$ bundle exec rake dhatu:import:data:services verbose=false
$ bundle exec rake dhatu:import:data:products verbose=false
```

## Overriding Import Data

You could override the seed files with your data.
just create db/import_data in your project folder and create the following files filled with your data in the required format (checkout the dummy csvs in usman db/import_data/dummy/features.csv) for the columns required

for e.g:

create users.csv in db/import_data/ foler and fill data in it and run 

```bash
$ bundle exec rake usman:import:users verbose=false
```

## Deployment Instructions

```bash
$ ssh deployer@34.250.212.49
```


