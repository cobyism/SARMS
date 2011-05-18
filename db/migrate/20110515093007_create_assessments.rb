class CreateAssessments < ActiveRecord::Migration
  def self.up
    create_table :assessments do |t|
      t.integer :unit_id
      t.string :name
      t.string :type
      t.datetime :due_at
      t.float :total_marks
      t.float :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :assessments
  end
end
