class RenameRowToShifRow < ActiveRecord::Migration
  def change
   rename_column :shift_row_assigns, :row_id, :shift_row_id
  end
end
