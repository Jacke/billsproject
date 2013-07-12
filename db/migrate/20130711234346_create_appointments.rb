class CreateAppointments < ActiveRecord::Migration
  def change
  	create_table :appointments do |t|
      t.integer :employee_id
      t.integer :site_id

      t.timestamps
    end
  end
end
