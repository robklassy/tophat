# README
Tophat Reddit-esque take home assignment from Rob Kalsi

# Install
Follow steps to get the project up and running on your local

## GCC/G++ 
Install `gcc` and `g++` C/C++ compiler for your platform if not already installed

## Clone Repo
Clone this repo

## Ruby Version Manager (RVM) https://rvm.io/
Install RVM to be able to manage different ruby versions
- do not install rails at the same time

## Ruby
Use RVM to install ruby
- go into the repo directory
- `rvm install 3.1.0`
- note depending on your platform this might need to compile if it can't find pre-compiled binaries

## Postgres
Install Postgres for your platform if not already installed
- make the following databases: `tophat_dev`, `tophat_test`, `tophat_prod`
- make the following user/pass: `test/blah` and `GRANT ALL PRIVILEGES` to the three databases created above

## Redis
Install Redis server for your platform if not already installed
- make sure `config/redis.rb` matches your Redis server configuration

## Bundler
Bundler lets you install all of the rubygems as listed in `Gemfile`
- go into repo directory
- `gem install bundler`

## Gems
Use bundler to install all of the gems
- go into repo directory
- `bundle install`

## Database Init
The databases need to be migrated, this is accomplished by using rails migration files, and must be done for `dev` and `test`
- go into repo directory
- `rake db:migrate`
- `RAILS_ENV=test rake db:migrate`

## Seed
Run the seeding script to populate the dev environment with some data
- PENDING
