# == Schema Information
#
# Table name: merchants
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  deposit     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Merchant < ActiveRecord::Base
	attr_accessible :employee_id, :deposit

  # Associations
	belongs_to :employee 
	has_many :merchant_cashouts

end
