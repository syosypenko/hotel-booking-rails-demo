# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

# Define stub assets tasks before loading other tasks to prevent tailwindcss-rails errors
namespace :assets do
  desc 'Precompile assets (stub for development)'
  task :precompile do
    puts "Assets precompile skipped in development mode"
  end

  desc 'Clean assets (stub for development)'
  task :clean do
    puts "Assets clean skipped in development mode"
  end

  desc 'Clobber assets (stub for development)'
  task :clobber do
    puts "Assets clobber skipped in development mode"
  end
end

Rails.application.load_tasks
