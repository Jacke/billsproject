module ShiftCalculation
  extend ActiveSupport::Concern

  included do
  	# relations, callbacks, validations, scopes and others...
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
