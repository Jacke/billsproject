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
#  percent     :integer
#

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
# TODO: Move methods to concerns
# TODO: Remade collection method (One line request, instance var assignment)
# TODO: Callback cleaning up
class Shift < ActiveRecord::Base
	cattr_accessor :current_site
	include TillCalculation
	before_save :old_values_collect, :if => :current_site
	after_save :row_collect, :if => :current_site
	after_save :till_calc, :if => :current_site
  attr_accessible :shiftstatus, 
								  :site_id, 
								  :employee_id, 
								  :balance, 
								  :till, 
								  :comment,
								  :shift_rows_attributes, 
								  :shift_row_assigns_attributes,
								  :percent, 
								  :shift_row_id


# row instance scope
  def self.row_scope(name, body)
    send(:define_method, name, &body)
  end
  def current_site
    Shift.current_site
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


 # instance methods

  def old_values_collect 
       @init_balance = self.balance
       @init_till = self.till # Define by admin at begining
  end

  def row_collect # that set after cancel shift
   balance = self.balance_vls.inject(:+).to_i 
   @balance_diff = @init_balance - balance # Diff for init balance and new(for all rows)
   
   @cashout = self.cashoutnow_vls.inject(:+)
   @encashmentIn = self.encashmentin_vls.inject(:+)
   @encashmentOut = self.encashmentout_vls.inject(:+)
   @expenses = self.expenses_vls.inject(:+)
   @percent = self.percent.to_i
 
  end
  
  def till_calc
   row_collect
   till = @init_till.to_i + @balance_diff.to_i + @encashmentOut.to_i - @expenses.to_i - @encashmentIn.to_i - @percent.to_i
   till
  end
# TODO: Default values in DB for refactoring that shift upper


end
