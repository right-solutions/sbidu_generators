if [ $# -eq 0 ]
  then
    echo "Invalid Usage"
    echo "USAGE: sh setup.sh <app_name>"
    echo "e.g: sh setup.sh demo-site.com"
  else
  	# In order to use the generator you need to first create a blank rails application to run the generator
    rails new $1 -T -d mysql --skip-bundle

    if [[ $? -ne 0 ]]; then
      echo "FAILED to create new rails application"
      exit 1
    fi

    # Go to the app folder
    cd $1

    # Add the generator gem 'sbidu_generators' to the Gemfile
    #echo "gem 'sbidu_generators'" >> Gemfile
    echo "gem 'sbidu_generators', path: '/Users/rightsolutions/Projects/Products/sbidu_generators'" >> Gemfile

    # Install all gems in the Gemfile
    bundle install

    if [[ $? -ne 0 ]]; then
      echo "FAILED to run bundle install"
      exit 1
    fi

    # Run the generator script for setup
    rails g sbidu_generators:setup $1

    if [[ $? -ne 0 ]]; then
      echo "FAILED to run the generator rake task to setup the rails app"
      exit 1
    fi

    # Remove Gemfile.lock and run the bundle install again
    rm Gemfile.lock && bundle

    # Copy required migration files from all engines
    rails railties:install:migrations
    if [[ $? -ne 0 ]]; then
      echo "FAILED to copy migrations from engines"
      exit 1
    fi

    # This is to avoid an error while runnig migrations locally
    rails db:environment:set RAILS_ENV=development

    # Create Database & run migration 
		rails db:drop db:create
    if [[ $? -ne 0 ]]; then
      echo "FAILED to drop and create the database"
      exit 1
    fi

    # Run migration for development environment
		rails db:migrate RAILS_ENV=development
    if [[ $? -ne 0 ]]; then
      echo "FAILED to run migration on development environment"
      exit 1
    fi

		# Run migration for test environment
		rails db:migrate RAILS_ENV=test
    if [[ $? -ne 0 ]]; then
      echo "FAILED to run migration on test environment"
      exit 1
    fi

		# Run the generator script for website
    rails g sbidu_generators:website $1
    if [[ $? -ne 0 ]]; then
      echo "FAILED to run the generator script for website"
      exit 1
    fi

    # Install all gems in the Gemfile
    bundle install
    if [[ $? -ne 0 ]]; then
      echo "FAILED to run bundle install"
      exit 1
    fi

    # Import required data
    rails import:data:all
    if [[ $? -ne 0 ]]; then
      echo "FAILED to import data"
      exit 1
    fi

    bundle exec cap install
    if [[ $? -ne 0 ]]; then
      echo "FAILED to run bundle exec cap install"
      exit 1
    fi

fi

