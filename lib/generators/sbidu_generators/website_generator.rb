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
    template "config/routes.rb",  "config/routes.rb"
  end

  def setup_webstite
    directory "app/controllers/website",  "app/controllers/website"
    directory "app/views/website",  "app/views/website"
    template "app/views/layouts/common/_banner.html.erb",  "app/views/layouts/common/_banner.html.erb"
  end

  private
  
  def print_args
    puts ":app_name: #{app_name}"
  end
  
end