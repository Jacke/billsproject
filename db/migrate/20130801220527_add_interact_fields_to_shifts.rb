class AddInteractFieldsToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :accept_at, :datetime
    add_column :shifts, :cancel_at, :datetime 
  end
end
