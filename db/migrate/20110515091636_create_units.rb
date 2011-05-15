class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.string :code
      t.string :name
      t.datetime :begins_at
      t.datetime :ends_at
      t.integer :term

      t.timestamps
    end
  end

  def self.down
    drop_table :units
  end
end
