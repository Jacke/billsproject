class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :site_id
      t.integer :employee_id
      t.integer :balance
      t.integer :expenses

      t.timestamps
    end
  end
end
