# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

task :drop_users => :environment do
  users_to_remove = Company.pluck(:db_user)
  users_to_remove.each do |user|
    puts "Dropping extra user: #{user}"
    ActiveRecord::Base.connection.execute("DROP USER #{user}")
  end
end

Rake::Task["db:drop"].enhance [:drop_users]
