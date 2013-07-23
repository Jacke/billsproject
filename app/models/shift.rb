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
	include TillCalculation
	before_save :old_values_collect, :if => self.site.shiftstatus
	after_save :row_collect, :till_calc, :if => self.site.shiftstatus
  attr_accessible :shiftstatus, 
								  :site_id, 
								  :employee_id, 
								  :balance, 
								  :till, 
								  :comment,
								  :shift_rows_attributes, 
								  :shift_row_assigns_attributes

# row instance scope
  def self.row_scope(name, body)
    send(:define_method, name, &body)
  end

# Initialize instance scope for every row type, retrive values
ShiftRow::TYPES.each do |rnm, rid|
row_scope "#{rnm}_vls".downcase.to_sym, ->(o = self) do 
	  ShiftRowAssign.joins(:shift_row).where(shift_rows: { row_type: rid }, shift_id: o.id).pluck(:def) 
  end
end	  

	# Associations
	has_many :shift_row_assigns 
	has_many :shift_rows, through: :shift_row_assigns  
	belongs_to :employee
	belongs_to :site
	accepts_nested_attributes_for :shift_rows, :shift_row_assigns

end
