module TillCalculation
  extend ActiveSupport::Concern

  included do
  	# relations, callbacks, validations, scopes and others...
  end

  module ClassMethods
  # row instance scope
    def self.row_scope(name, body)
      send(:define_method, name, &body)
    end
  end

  # instance methods

  def old_values_collect # that set initially 
     @init_balance = self.balance
     @init_till = self.till # Define by admin at begining
  end


  def row_collect # that set after cancel shift
   balance = self.balance_vls.inject(:+) + self.balance # it's new balance variables
   @balance_diff = @init_balance - balance # Diff for init balance and new(for all rows)
   
   @cashout = self.cashoutnow_vls.inject(:+)
   @encashmentIn = self.encashmentin_vls.inject(:+)
   @encashmentOut = self.encashmentout_vls.inject(:+)
   @expenses = self.expenses_vls.inject(:+)
   @percent = self.percent
  end
  def till_calc
   till = @init_till.to_i + @balance_diff.to_i + @encashmentOut.to_i - @expenses.to_i - @encashmentIn.to_i - @percent.to_i
   update_till(till)
  end

  def update_till(new_till)
     self.update_attribute('till', new_till)
  end
  

#  refactor
#  require 'sourcify'
#*****
#Star skills
#
#	  get_vls do |shift|
#	    shift.cashoutnow_vls
#	    shift.encashmentin_vls
#	    shift.encashmentout_vls
#	    shift.expenses_vls
#	    shift.percent
#	    shift.balance
#	  end
#  &block.to_source(:strip_enclosure => true).split("\n")
#  def get_vls(&block)
#  	a = block.to_source(:strip_enclosure => true).split("\n")
#  	a.each do |n|
#  	value = self.send("#{n}")
#  	value.inject(:+) if value.kind_of?(Array)
#  	instance_variable_set("@#{n}", value)
#  	end
#  end

end
