namespace :db do
  desc "Populate SARMS with an Administrator"
  task :bootstrap => :environment do
    require 'populator'
    require 'faker'

    #INSERT INTO "users" ("updated_at", "lastname", "password_hash", "is_faculty", "email", "password_salt", "is_admin", "firstname", "created_at", "status") VALUES ('2011-05-15 08:53:40.426761', '', '$2a$10$w3exUK//kO017D6OufJcjuSbo.Wj8RdmsKaiIfbSxwRsZdc3Qk1Cq', 't', 'admin@sarms.com', '$2a$10$w3exUK//kO017D6OufJcju', 't', 'Administrator', '2011-05-15 08:53:40.426761', 0)

    # Create a new administrator account
    # Email: admin@sarms.com
    # Password: admin
    admin = User.new(
      :email => "admin@sarms.com",
      :password => "admin",
      :password_confirmation => "admin",
      # :password_hash => "$2a$10$w3exUK//kO017D6OufJcjuSbo.Wj8RdmsKaiIfbSxwRsZdc3Qk1Cq",
      # :password_salt => "$2a$10$w3exUK//kO017D6OufJcju",
      :firstname => "Administrator",
      :lastname => "",
      :status => 0,
      :is_faculty => true,
      :is_admin => true
    )
    if admin.save
      puts "Administrator created!"
    else
      puts "Could not create administrator"
    end
  end
end
