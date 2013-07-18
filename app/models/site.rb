class Site < ActiveRecord::Base
  attr_accessible :name, :direction
  

  has_many :appointments

  has_many :employees, through: :appointments 
  has_many :shifts
end
