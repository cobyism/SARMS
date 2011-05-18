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

  desc "Populate with test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User.where('email != ?', "admin@sarms.com"), Unit, Enrollment, FacultyAssignment].each(&:delete_all)
    
    User.populate 10 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.is_admin = false
      user.is_faculty = false
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    User.populate 8 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.is_admin = false
      user.is_faculty = true
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    User.populate 3 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.is_admin = true
      user.is_faculty = true
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    Unit.populate 12 do |unit|
      unit.code = ["MSC228", "SIT321", "SIT282", "SIT384", "SIT772", "MSC337", "SIT190", "SIT112", "SIT180", "SIT358", "MSC722", "SIT289", "SIT661", "SIT934", "SIT013"]
      unit.name = ["Intro to Subject", "Advanced Subject", "Subject Management", "Zen and the Art of Subject"]
      unit.begins_at = ["1/3/2012".to_datetime, "1/7/2012".to_datetime, "1/11/2012".to_datetime]
      unit.term = [1, 2, 3]
      unit.created_at = 2.years.ago..Time.now
      unit.updated_at = unit.created_at..Time.now
    end
    
    User.students.each do |student|
      Enrollment.populate 1..3 do |enrollment|
        enrollment.user_id = student.id
        enrollment.unit_id = 1..Unit.all.count
      end
    end
    
    User.staff.each do |staff|
      FacultyAssignment.populate 1..2 do |faculty_assignment|
        faculty_assignment.user_id = staff.id
        faculty_assignment.unit_id = 1..Unit.all.count
      end
    end
    
  end

  desc "Populate with test data"
  task :wipe => :environment do
    [User, Unit, Enrollment, FacultyAssignment].each(&:delete_all)
  end
end

