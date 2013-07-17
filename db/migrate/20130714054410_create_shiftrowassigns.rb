class CreateShiftrowassigns < ActiveRecord::Migration
  def change
    create_table :shiftrowassigns do |t|
      t.integer :row_id
      t.integer :def
      t.integer :shift_id

      t.timestamps
    end
  end
end
