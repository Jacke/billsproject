class DepositDefaultValueInteger < ActiveRecord::Migration
  def change
     remove_column :merchants, :deposit
     add_column :merchants, :deposit, :integer, default: 0
  end
end
