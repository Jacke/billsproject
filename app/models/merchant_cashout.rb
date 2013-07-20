# == Schema Information
#
# Table name: merchant_cashouts
#
#  id          :integer          not null, primary key
#  merchant_id :integer
#  cashout_sum :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class MerchantCashout < ActiveRecord::Base
  attr_accessible :cashout_sum

  belongs_to :merchant

end
