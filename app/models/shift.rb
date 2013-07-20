# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  site_id     :integer
#  employee_id :integer
#  balance     :integer
#  till        :integer
#  created_at  :datetime
#  updated_at  :datetime
#  comment     :text
#

class Shift < ActiveRecord::Base
  attr_accessible :shiftstatus, :site_id, :employee_id, :balance, :expenses
	
	# Associations
	has_many :shift_row_assigns 
	has_many :shift_rows, through: :shift_row_assigns  
	belongs_to :employee
	belongs_to :site

end
