class SplitEmployeeNameFirstLast < ActiveRecord::Migration
  def change
   rename_column :employees, :name, :first_name
   add_column :employees, :last_name, :string    
  end
end
