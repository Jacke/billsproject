# == Schema Information
#
# Table name: shift_rows
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  row_type   :integer
#  created_at :datetime
#  updated_at :datetime
#  site_id    :integer
#

class ShiftRow < ActiveRecord::Base
  
TYPES = [
    #  Displayed stored in db you can use integer or strings at per field.
    [ "Balance",            1 ],
    [ "CashoutNow",         2 ],
    [ "EncashmentIn",       3 ],
    [ "EncashmentOut",      4 ],
    [ "Expenses",           5 ],
    [ "OldBalance",         6 ]
]
	ShiftRow::TYPES.each do |row_name, id|
	  scope "#{row_name}_type".to_sym, -> { where(row_type: id) }
	end

  attr_accessible :title, :row_type, :site_id

	# Associations
	has_many :shift_row_assigns 
	has_many :shifts, through: :shift_row_assigns
	belongs_to :site
  accepts_nested_attributes_for :shifts, :shift_row_assigns
 def rowtype # Return type of row in human language
    ShiftRow::TYPES.find_all{|row_name, id| id == self.row_type}.flatten.first
 end



end
