class RenameExpensesColumn < ActiveRecord::Migration
  def change
   rename_column :shifts, :expenses, :till
  end
end
