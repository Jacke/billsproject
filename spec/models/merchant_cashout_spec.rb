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

require 'spec_helper'

describe MerchantCashout do
  pending "add some examples to (or delete) #{__FILE__}"
end
