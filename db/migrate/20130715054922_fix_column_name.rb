class FixColumnName < ActiveRecord::Migration
  def change
   rename_column :shift_rows, :type, :row_type
  end
end
