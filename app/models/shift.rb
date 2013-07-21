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
  attr_accessible :shiftstatus, 
								  :site_id, 
								  :employee_id, 
								  :balance, 
								  :till, 
								  :comment,
								  :shift_rows_attributes, 
								  :shift_row_assigns_attributes

	ShiftRow::TYPES.each do |row_name, id|
	  scope "#{row_name}_row".to_sym, -> { where(row_type: id) }
	end
	# Associations
	has_many :shift_row_assigns 
	has_many :shift_rows, through: :shift_row_assigns  
	belongs_to :employee
	belongs_to :site
	accepts_nested_attributes_for :shift_rows, :shift_row_assigns
	
end
