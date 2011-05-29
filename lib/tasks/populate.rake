namespace :db do
  desc "Populate with test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User.where('email != ?', "admin@sarms.com"), Unit, Enrollment, FacultyAssignment, Activity, Assessment, Attendance, Performance, Note, AtRiskEvent, Response].each(&:delete_all)
    
    User.populate 40 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.title = Faker::Name.prefix
      user.phone = Faker::PhoneNumber.phone_number
      user.mobile = Faker::PhoneNumber.phone_number
      user.address = "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}"
      user.exam_location = ['GLCDQ', 'ROCDQ', 'HOBDT', 'MELDV', 'WRRV', 'MELDV', 'WRRV']
      user.is_active = true
      user.is_admin = false
      user.is_faculty = false
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    User.populate 12 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.title = Faker::Name.prefix
      user.phone = Faker::PhoneNumber.phone_number
      user.mobile = Faker::PhoneNumber.phone_number
      user.address = "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}"
      user.is_active = true
      user.is_admin = false
      user.is_faculty = true
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    User.populate 4 do |user|
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.title = Faker::Name.prefix
      user.phone = Faker::PhoneNumber.phone_number
      user.mobile = Faker::PhoneNumber.phone_number
      user.address = "#{Faker::Address.street_address}\n#{Faker::Address.city}\n#{Faker::Address.us_state}\n#{Faker::Address.zip_code}"
      user.is_active = true
      user.is_admin = true
      user.is_faculty = true
      user.created_at = 3.years.ago..Time.now
      user.updated_at = user.created_at..Time.now
    end
    
    Unit.populate 12 do |unit|
      unit.code = ["MSC228", "SIT321", "SIT282", "SIT384", "SIT772", "MSC337", "SIT190", "SIT112", "SIT180", "SIT358", "MSC722", "SIT289", "SIT661", "SIT934", "SIT013", "MSC223", "SIT311", "SIT286", "SIT324", "SIT712", "MSC137", "SIT140", "SIT172", "SIT110", "SIT318", "MSC122", "SIT299", "SIT691", "SIT134", "SIT113"]
      unit.name = ["Intro to Subject", "Advanced Subject", "Subject Management", "Zen and the Art of Subject", "Intro to Art History", "Advanced Drawing", "Scope Management", "Zen and the Art of Painting Walls", "Intro to Modern History", "Advanced Database Systems", "Project Management", "Zen and the Art of Playing Warcraft", "Intro to Planking", "Advanced Planking", "Scope Management", "Zen and the Art of Planking"]
      unit.begins_at = ["1/3/2012".to_datetime, "1/7/2012".to_datetime, "1/11/2012".to_datetime]
      unit.ends_at = unit.begins_at + 3.months
      unit.term = [1, 2, 3]
      unit.created_at = 2.years.ago..Time.now
      unit.updated_at = unit.created_at..Time.now
      start_date = unit.created_at
      weekly = start_date
      i = 1
      Activity.populate 12 do |activity|
        activity.unit_id = unit.id
        activity.name = "Lecture #{i}"
        activity.created_at = start_date
        activity.updated_at = start_date
        activity.date = weekly
        weekly += 1.week
      end
      weekly = start_date
      i = 1
      Activity.populate 8 do |activity|
        activity.unit_id = unit.id
        activity.name = "Tutorial #{i}"
        activity.created_at = start_date
        activity.updated_at = start_date
        activity.date = weekly
        weekly += 1.week
      end
      @weight_sum = 0
      @assessment_count = 1
      Assessment.populate 2..4 do |assessment|
        assessment.unit_id = unit.id
        assessment.name = "Assessment #{@assessment_count}"
        assessment.category = ["Quiz", "Assignment", "Assignment", "Mid-term"]
        assessment.total_marks = [10, 15, 45, 60, 80, 120]
        assessment.due_at = unit.ends_at - rand(60).days + rand(8).hours + 9.hours
        assessment.weight = [10, 15, 15, 20]
        @assessment_count += 1
        @weight_sum += assessment.weight
      end
      Assessment.populate 1 do |assessment|
        assessment.unit_id = unit.id
        assessment.name = "Final Exam"
        assessment.category = "Examination"
        assessment.total_marks = [80, 120, 140, 190, 200]
        assessment.due_at = (unit.ends_at - 7.days) + rand(8).hours + 9.hours
        assessment.weight = 100 - @weight_sum
      end
    end
    
    User.students.each do |student|
      Enrollment.populate 3..4 do |enrollment|
        enrollment.user_id = student.id
        enrollment.unit_id = 1..Unit.all.count
        enrollment.created_at = 2.years.ago..Time.now
        count = 1
        Unit.find(enrollment.unit_id).activities.each do |activity|
          if rand(8) > 1
            Attendance.populate 1 do |attendance|
              attendance.enrollment_id = enrollment.id
              attendance.activity_id = activity.id
            end
          end
          count += 1
          count = 1 if count == 12
        end
        count = 1
        Unit.find(enrollment.unit_id).assessments.each do |assessment|
          if rand(80) > 1
            Performance.populate 1 do |performance|
              performance.enrollment_id = enrollment.id
              performance.assessment_id = assessment.id
              performance.achieved_mark = assessment.total_marks - rand(assessment.total_marks * 0.75)
            end
          end
          count += 1
          count = 1 if count == 12
        end
        Note.populate 0..4 do |note|
          note.enrollment_id = enrollment.id
          note.user_id = User.faculty.find(:first, :offset =>rand(User.faculty.count))
          note.content = [
            "This student has been consistently absent from activities",
            "This student has been somewhat absent from activities",
            "Hi there, can you please contact your lecturer for this subject?",
            "Where have you been! I tried to give you your marks back for your assignment, but you haven't been at class!",
            "Excellent student. Thanks for your great participation in class this week",
            "About that question you had, I found an example. Come and see me in my office and I'll explain it to you."
            ]
          note.created_at = enrollment.created_at..Time.now
        end
      end
    end
    
    User.faculty.each do |faculty|
      FacultyAssignment.populate 1..2 do |faculty_assignment|
        faculty_assignment.user_id = faculty.id
        faculty_assignment.unit_id = 1..Unit.all.count
      end
    end

  end
end

