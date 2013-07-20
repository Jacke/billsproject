# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  site_id     :integer
#  employee_id :integer
#  balance     :integer
#  till        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Shift < ActiveRecord::Base
attr_accessible :shiftstatus, :site_id, :employee_id, :balance, :expenses
belongs_to :employee
belongs_to :site
end
