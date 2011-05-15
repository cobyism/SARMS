class CreateAtRiskEvents < ActiveRecord::Migration
  def self.up
    create_table :at_risk_events do |t|
      t.integer :enrollment_id
      t.datetime :viewed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :at_risk_events
  end
end
