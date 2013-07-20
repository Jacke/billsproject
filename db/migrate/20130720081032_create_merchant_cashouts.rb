class CreateMerchantCashouts < ActiveRecord::Migration
  def change
    create_table :merchant_cashouts do |t|
      t.integer :merchant_id
      t.integer :cashout_sum

      t.timestamps
    end
  end
end
