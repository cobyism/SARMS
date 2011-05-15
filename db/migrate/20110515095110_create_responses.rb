class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.integer :user_id
      t.integer :at_risk_event_id
      t.string :response
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
