class AddSiteIdToShiftRows < ActiveRecord::Migration
  def change
   add_column :shift_rows, :site_id, :integer
  end
end
