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
  def row_collect
   # balance shit
   balance_init = self.balance
   # old till
   old_till = self.till


   @balance_diff = balance_init - balance
   balance = self.balance_vls.inject(:+)
   @cashout = self.cashoutnow_vls.inject(:+)
   @encashmentIn = self.encashmentin_vls.inject(:+)
   @encashmentOut = self.encashmentout_vls.inject(:+)
   @expenses = self.expenses_vls.inject(:+)
   @percent = self.percent
   @till = old_till + @balance_diff + @encashmentOut - @expenses - @encashmentIn - @percent
   @till
  end

  def update_till(new_till)
     self.update_attribute('till', new_till)
  end

  
end
