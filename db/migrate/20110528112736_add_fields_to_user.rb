class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :title, :string
    add_column :users, :exam_location, :string
    add_column :users, :course_code, :string
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
  end

  def self.down
    remove_column :users, :mobile
    remove_column :users, :phone
    remove_column :users, :address
    remove_column :users, :course_code
    remove_column :users, :exam_location
    remove_column :users, :title
  end
end
