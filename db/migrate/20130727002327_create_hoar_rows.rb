class CreateHoarRows < ActiveRecord::Migration
  def change
    create_table :hoar_rows do |t|
      t.integer :shift_id
      t.integer :till, default: 0
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
