require 'csv'
require 'open-uri'
require 'time'

namespace 'import' do
  namespace 'data' do

    desc "Import all data in sequence"
    task 'all' => :environment do

      begin

        # First import all Master Data
        puts "Importing Master Data \t".cyan
        
        puts "Importing Features \t".yellow
        Rake::Task["usman:import:master_data:features"].invoke

        puts "Importing Roles \t".yellow
        Rake::Task["usman:import:master_data:roles"].invoke

        # Import Users & Permissions
        puts "Importing Users & Permissions \t".cyan

        puts "Importing Users \t".yellow
        Rake::Task["usman:import:data:users"].invoke

        puts "Importing permissions \t".yellow
        Rake::Task["usman:import:data:permissions"].invoke

        # Import Other Data
        puts "Importing Other Data \t".cyan

      rescue ArgumentError => e
          puts "Loading data - failed - #{e.message}".red
      rescue Exception => e
        puts "Importing data - failed - #{e.message}".red
        puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      end
      puts " "
      
    end

    ["Feature", "Role"].each do |cls_name|
      name = cls_name.underscore.pluralize
      desc "Load Master Data - #{cls_name.pluralize}"
      task name => :environment do
        puts "Importing #{name} \t".yellow
        Rake::Task["usman:import:master_data:#{name}"].invoke
      end
    end

    ["User", "Permission"].each do |cls_name|
      name = cls_name.underscore.pluralize
      desc "Load Data - #{cls_name.pluralize}"
      task name => :environment do
        puts "Importing #{name} \t".yellow
        Rake::Task["usman:import:data:#{name}"].invoke
      end
    end

    {
      # blog_posts: "Dhatu::BlogPost"
    }.each do |simple_name, cls_name|
      name = cls_name.underscore.pluralize
      desc "Load Data - #{simple_name.to_s.titleize}"
      task simple_name => :environment do
        puts "Importing #{simple_name.to_s.titleize} \t".yellow
        Rake::Task["dhatu:import:data:#{name}"].invoke
      end
    end

    namespace 'dummy' do
      
      desc "Import all dummy data in sequence"
      task 'all' => :environment do

        begin

          # First import all Master Data
          puts "Importing Master Data \t".cyan
        
          puts "Importing Features \t".yellow
          Rake::Task["usman:import:master_data:features"].invoke

          puts "Importing Roles \t".yellow
          Rake::Task["usman:import:master_data:roles"].invoke

          # Import Users & Permissions
          puts "Importing Users & Permissions \t".cyan

          puts "Importing Users \t".yellow
          Rake::Task["usman:import:data:dummy:users"].invoke

          puts "Importing permissions \t".yellow
          Rake::Task["usman:import:data:dummy:permissions"].invoke

          # Import Other Data
          puts "Importing Other Data \t".cyan

        rescue ArgumentError => e
            puts "Import Failed - #{e.message}".red
        rescue Exception => e
          puts "Importing Failed - #{e.message}".red
          puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
        end
        puts " "

      end

      ["User", "Permission"].each do |cls_name|
        name = cls_name.underscore.pluralize
        desc "Load Data - #{cls_name.pluralize}"
        task name => :environment do
          puts "Importing #{name} \t".yellow
          Rake::Task["usman:import:data:dummy:#{name}"].invoke
        end
      end

      {
        # blog_posts: "Dhatu::BlogPost"     
      }.each do |simple_name, cls_name|
          name = cls_name.underscore.pluralize
          desc "Load Data - #{simple_name.to_s.titleize}"
          task simple_name => :environment do
            puts "Importing #{simple_name.to_s.titleize} \t".yellow
            Rake::Task["dhatu:import:data:dummy:#{name}"].invoke
          end
      end

    end
  end
end
    