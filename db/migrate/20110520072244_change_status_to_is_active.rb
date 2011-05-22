class ChangeStatusToIsActive < ActiveRecord::Migration
  def self.up
    remove_column :users, :status
    add_column :users, :is_active, :boolean, :default => true
  end

  def self.down
    add_column :users, :status, :integer, :default => 0
    remove_column :users, :is_active
  end
end
