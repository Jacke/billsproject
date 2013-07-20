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
 
 attr_accessible :title, :row_type
 has_many :shifts, through: :shiftrowassigns  
end
