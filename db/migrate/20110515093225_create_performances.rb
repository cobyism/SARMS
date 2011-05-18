class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances do |t|
      t.integer :enrollment_id
      t.integer :assessment_id
      t.float :achieved_mark

      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end
