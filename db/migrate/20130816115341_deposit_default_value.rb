class DepositDefaultValue < ActiveRecord::Migration
  def change
     change_column :merchants, :deposit, :string, default: 0
  end
end
