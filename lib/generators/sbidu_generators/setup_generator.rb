require 'rails/generators'

class SbiduGenerators::SetupGenerator < Rails::Generators::Base
  
  source_root File.expand_path('../setup_templates', __FILE__)
  
  desc "Copies the basic files to kick start a new sbidu app"
  
  argument :app_name, :type=>:string
  # argument :fields, :type=>:hash, :banner =>"Resource Fields."
  
  class_option :debug, :type => :boolean, :default => false, :desc => "This will print the arguments for debugging"
  
  def debug_args
    print_args if options.debug?
  end

  def start_setting_up
    # Copy .gitignore, Dockerfile, 
    template "gitignore", ".gitignore", force: true
    template "rspec", ".rspec", force: true
    template "ruby-version", ".ruby-version", force: true
    template "Gemfile", "Gemfile", force: true
    template "README.md", "README.md", force: true

    # Copy Docker related files
    template "Dockerfile", "Dockerfile", force: true
    template "docker-compose.yml", "docker-compose.yml", force: true

    # Create the configuration files
    template "config/application.yml", "config/application.yml", force: true
    template "config/database.yml", "config/database.yml", force: true
    template "config/database.sample.yml", "config/database.yml", force: true
    template "config/nginx.conf", "config/nginx.conf", force: true
    template "config/nginx.conf", "config/carrierwave.rb", force: true

    # Copy Deploy Configurations
    template "Capfile", "Capfile", force: true
    template "config/deploy.rb", "config/deploy.rb", force: true

    # Copy Initializers
    template "config/initializers/assets.rb", "config/initializers/assets.rb", force: true
    template "config/initializers/overide_kuppayam_controllers.rb", "config/initializers/overide_kuppayam_controllers.rb", force: true
    template "config/initializers/overide_pattana_controllers.rb", "config/initializers/overide_pattana_controllers.rb", force: true
    template "config/initializers/overide_usman_controllers.rb", "config/initializers/overide_usman_controllers.rb", force: true
    template "config/initializers/overide_dhatu_controllers.rb", "config/initializers/overide_dhatu_controllers.rb", force: true

    # Copy Import Data and Data CSVs
    directory "db/data", "db/data"
    directory "db/master_data", "db/master_data"

    # Copy data.rake task
    template "lib/tasks/data.rake", "lib/tasks/data.rake", force: true
  end

  def configure_routes
    # Dashboard Page - Landing Page Redirects to this page
    route "get   '/dashboard',   to: 'dashboard#index',  as:   :dashboard"

    # Default Landing Page after successful signin
    route "get   '/landing', to: 'landing#index',  as: :user_landing"

    # Website Pages
    route "root  'website/home#index'"

    # Mount required engines
    route "mount Pattana::Engine => '/'"
    route "mount Usman::Engine => '/'"
    route "mount Dhatu::Engine => '/'"
  end

  def setup_controllers
    template "app/controllers/application_controller.rb",  "app/controllers/application_controller.rb", force: true
    template "app/controllers/dashboard_controller.rb",  "app/controllers/dashboard_controller.rb", force: true
    template "app/controllers/landing_controller.rb",  "app/controllers/landing_controller.rb", force: true
    template "app/controllers/website/base_controller.rb",  "app/controllers/website/base_controller.rb", force: true
    template "app/controllers/website/home_controller.rb",  "app/controllers/website/home_controller.rb", force: true
  end

  def setup_views
    remove_file "app/views/application.html.erb"
    directory "app/views/dashboard",  "app/views/dashboard"
    directory "app/views/layouts",  "app/views/layouts"
    directory "app/views/website/home",  "app/views/website/home"
  end

  def setup_basic_assets
    template "app/assets/stylesheets/starter_kit.css", "app/assets/stylesheets/starter_kit.css", force: true
    template "app/assets/javascripts/starter_kit.js", "app/assets/javascripts/starter_kit.js", force: true

    directory "app/assets/stylesheets/starter_kit", "app/assets/stylesheets/starter_kit"
    directory "app/assets/javascripts/starter_kit", "app/assets/javascripts/starter_kit"
  end

  private
  
  def print_args
    puts ":app_name: #{app_name}"
  end
  
end