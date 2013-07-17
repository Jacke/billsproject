class RenameShiftRowTable < ActiveRecord::Migration
  def change
   rename_table :shiftrows, :shift_rows
   rename_table :shiftrowassigns, :shift_row_assigns
  end

end
