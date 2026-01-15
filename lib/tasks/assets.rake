# Stub assets tasks for minimal Rails setup
namespace :assets do
  desc 'Precompile assets (stub for development)'
  task precompile: :environment do
    puts "Assets precompile skipped in development mode"
  end

  desc 'Clean assets (stub for development)'
  task clean: :environment do
    puts "Assets clean skipped in development mode"
  end

  desc 'Clobber assets (stub for development)'
  task clobber: :environment do
    puts "Assets clobber skipped in development mode"
  end
end
