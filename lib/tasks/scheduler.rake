desc "This task is called by the Heroku scheduler add-on"
task :recall_check => :environment do
  puts "Performing recall check..."
  Appliance.weekly_recall_check
  puts "done."
end

task :monthly_email => :environment do
  puts "Sending monthly email..."
  User.monthly_email
  puts "done."
end