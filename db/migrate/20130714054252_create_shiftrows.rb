class CreateShiftrows < ActiveRecord::Migration
  def change
    create_table :shiftrows do |t|
      t.string :title
      t.integer :type

      t.timestamps
    end
  end
end
