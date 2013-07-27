# == Schema Information
#
# Table name: hoar_rows
#
#  id         :integer          not null, primary key
#  shift_id   :integer
#  till       :integer          default(0)
#  balance    :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

class HoarRow < ActiveRecord::Base

attr_accessible :shift_id, :till, :balance

belongs_to :shifts
end
