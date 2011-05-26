class RenameAssessmentTypeToCategory < ActiveRecord::Migration
  def self.up
    remove_column :assessments, :type
    add_column :assessments, :category, :string
  end

  def self.down
    remove_column :assessments, :category
    add_column :assessments, :type, :string
  end
end
