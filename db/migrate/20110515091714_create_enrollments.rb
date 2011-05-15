class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.integer :user_id
      t.integer :unit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollments
  end
end
