class AddCommentsToShifts < ActiveRecord::Migration
  def change
   add_column :shifts, :comment, :text
  end
end
