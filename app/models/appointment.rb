class Appointment < ActiveRecord::Base
  attr_accessor :employee_id, :site_id
	belongs_to :employee
	belongs_to :site

end
