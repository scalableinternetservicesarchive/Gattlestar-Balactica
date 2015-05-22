namespace :update do
  desc "Reset daily downloads for all users to 0"
  task :reset_daily_downloads => :environment do
  	User.update_all(docs_uploaded_today: 0)
  	puts "Reset daily downloads to 0"
  end
end
