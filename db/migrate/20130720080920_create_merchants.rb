class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.integer :employee_id
      t.integer :deposit

      t.timestamps
    end
  end
end
