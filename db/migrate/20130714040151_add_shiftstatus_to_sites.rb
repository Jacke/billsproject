class AddShiftstatusToSites < ActiveRecord::Migration
  def change
    add_column :sites, :shiftstatus, :boolean, default: false
  end
end
