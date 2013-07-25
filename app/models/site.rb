# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  direction   :text
#  created_at  :datetime
#  updated_at  :datetime
#  shiftstatus :boolean          default(FALSE)
#

class Site < ActiveRecord::Base
  attr_accessible :name, :direction, :shiftstatus
  

  has_many :appointments

  has_many :employees, through: :appointments 
  has_many :shifts
  has_many :shift_rows
end
