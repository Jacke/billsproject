# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  employee_id :integer
#  site_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Appointment < ActiveRecord::Base
  attr_accessor :employee_id, :site_id
	belongs_to :employee
	belongs_to :site

end
