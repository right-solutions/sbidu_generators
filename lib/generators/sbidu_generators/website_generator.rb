require 'rails/generators'

class SbiduGenerators::WebsiteGenerator < Rails::Generators::Base
  
  source_root File.expand_path('../website_templates', __FILE__)
  
  desc "Copies the generic website htmls to kick start a new sbidu app"
  
  argument :app_name, :type=>:string
  # argument :fields, :type=>:hash, :banner =>"Resource Fields."
  
  class_option :debug, :type => :boolean, :default => false, :desc => "This will print the arguments for debugging"
  
  def debug_args
    print_args if options.debug?
  end

  def configure_routes
    template "config/routes.rb",  "config/routes.rb", force: true
  end

  def setup_webstite
    directory "app/controllers/website",  "app/controllers/website", force: true
    directory "app/views/website",  "app/views/website", force: true
    template "app/views/layouts/common/_banner.html.erb",  "app/views/layouts/common/_banner.html.erb", force: true
  end

  def copy_seed_data
    puts "Copying Seed Data"

    # Copy Import Data and Data CSVs
    directory "db/data", "db/data", force: true
    directory "db/master_data", "db/master_data", force: true

    # Copy data.rake task
    template "lib/tasks/data.rake", "lib/tasks/data.rake", force: true
  end

  private
  
  def print_args
    puts ":app_name: #{app_name}"
  end
  
end