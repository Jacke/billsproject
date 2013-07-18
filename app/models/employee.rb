class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :phone, 
  								:name, 
  								:sites_attributes, 
  								:email, 
  								:admin, 
  								:password, 
  								:password_confirmation, 
  								:remember_me

  # Associations
  has_many :appointments
  has_many :shifts
  has_many :sites, through: :appointments 

  accepts_nested_attributes_for :sites
  accepts_nested_attributes_for :appointments
end
