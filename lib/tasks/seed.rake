namespace :db do
  desc "Populate SARMS with an Administrator"
  task :seed => :environment do
    require 'populator'
    require 'faker'

    [User, Unit, Enrollment, FacultyAssignment, Activity, Assessment, Attendance, Performance, Note, AtRiskEvent, Response].each(&:delete_all)

    # Create a new administrator account
    # Email: admin@sarms.com
    # Password: admin
    admin = User.new(
      :email => "admin@sarms.com",
      :password => "admin",
      :password_confirmation => "admin",
      :firstname => Faker::Name.first_name,
      :lastname => Faker::Name.last_name,
      :title => Faker::Name.prefix,
      :phone => Faker::PhoneNumber.phone_number,
      :mobile => Faker::PhoneNumber.phone_number,
      :address => "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}",
      :is_active => true,
      :is_faculty => true,
      :is_admin => true
    )
    if admin.save
      puts "Administrator created!"
    else
      puts "Could not create administrator"
    end
    
    # Create a new student account
    # Email: student@sarms.com
    # Password: student
    student = User.new(
      :email => "student@sarms.com",
      :password => "student",
      :password_confirmation => "student",
      :is_active => true,
      :is_faculty => false,
      :is_admin => false,
      :firstname => Faker::Name.first_name,
      :lastname => Faker::Name.last_name,
      :title => Faker::Name.prefix,
      :phone => Faker::PhoneNumber.phone_number,
      :mobile => Faker::PhoneNumber.phone_number,
      :address => "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}",
      :course_code => 'S334',
      :exam_location => 'GLCDQ',
      :created_at => 3.years.ago,
      :updated_at => Time.now
    )
    if student.save
      puts "Student created!"
    else
      puts "Could not create student"
    end
    
    # Create a new faculty account
    # Email: faculty@sarms.com
    # Password: faculty
    faculty = User.new(
      :email => "faculty@sarms.com",
      :password => "faculty",
      :password_confirmation => "faculty",
      :is_active => true,
      :is_faculty => true,
      :is_admin => false,
      :firstname => Faker::Name.first_name,
      :lastname => Faker::Name.last_name,
      :title => Faker::Name.prefix,
      :phone => Faker::PhoneNumber.phone_number,
      :mobile => Faker::PhoneNumber.phone_number,
      :address => "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}",
      :created_at => 3.years.ago,
      :updated_at => Time.now
    )
    if faculty.save
      puts "Faculty created!"
    else
      puts "Could not create faculty"
    end
  end
end