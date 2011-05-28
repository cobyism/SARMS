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
      :firstname => "System",
      :lastname => "Administrator",
      :is_active => true,
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