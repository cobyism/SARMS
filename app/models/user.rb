class User < ActiveRecord::Base
  has_many :enrollments, :dependent => :destroy
  has_many :faculty_assignments, :dependent => :destroy
  has_many :units, :through => :enrollments
  has_many :units, :through => :faculty_assignments
  attr_accessible :email, :password, :password_confirmation, :firstname, :lastname, :is_active, :is_faculty, :is_admin, :title, :exam_location, :course_code, :address, :phone, :mobile

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  validates_presence_of :firstname, :lastname, :email
  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i

  named_scope :students, :conditions => { :is_admin => false, :is_faculty => false }
  named_scope :faculty, :conditions => { :is_admin => false, :is_faculty => true }
  named_scope :admins, :conditions => { :is_admin => true, :is_faculty => true }
  
  def current_gpa
    total = 0
    count = 0
    self.enrollments.each do |e|
        p = e.performance_percentage
        if p >= 80
          total += 7
        elsif p >= 70
          total += 6
        elsif p >= 60
          total += 5
        elsif p >= 50
          total += 4
        else
          total += 3
        end
        count += 1
    end
    total / count
  end

  def role
    if self.is_admin
      "Administrator"
    elsif self.is_faculty
      "Faculty"
    else
      "Student"
    end
  end
  
  def is_student?
    !self.is_faculty
  end
  
  def is_faculty?
    self.is_faculty && !self.is_admin
  end
  
  def is_staff?
    self.is_faculty
  end
  
  def is_admin?
    self.is_admin
  end

  def status
    if self.is_active?
      "Active"
    else
      "Suspended"
    end
  end
  
  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
