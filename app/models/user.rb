class User < ActiveRecord::Base
  has_many :enrollments
  has_many :faculty_assignments
  attr_accessible :email, :password, :password_confirmation, :firstname, :lastname, :status, :is_faculty, :is_admin

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  named_scope :students, :conditions => { :is_admin => false, :is_faculty => false }
  named_scope :staff, :conditions => { :is_faculty => false }
  named_scope :faculty, :conditions => { :is_admin => false, :is_faculty => true }
  named_scope :admins, :conditions => { :is_admin => true, :is_faculty => true }

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
