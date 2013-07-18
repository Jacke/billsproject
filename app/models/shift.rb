class Shift < ActiveRecord::Base
attr_accessible :shiftstatus, :site_id, :employee_id, :balance, :expenses
belongs_to :employee
belongs_to :site
end
