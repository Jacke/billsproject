class ShiftRow < ActiveRecord::Base
 
 attr_accessible :title, :row_type
 has_many :shifts, through: :shiftrowassigns  
end
