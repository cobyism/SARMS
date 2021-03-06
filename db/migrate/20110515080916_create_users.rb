class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :firstname
      t.string :lastname
      t.integer :status
      t.boolean :is_faculty
      t.boolean :is_admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
