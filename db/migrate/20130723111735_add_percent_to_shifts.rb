class AddPercentToShifts < ActiveRecord::Migration
  def change
   add_column :shifts, :percent, :integer
  end
end

