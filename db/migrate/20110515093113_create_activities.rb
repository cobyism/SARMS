class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :unit_id
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
