# == Schema Information
#
# Table name: employees
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  phone                  :string(255)
#  admin                  :boolean
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class Employee < ActiveRecord::Base
	after_save :new_merchant
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :phone, 
  		  :first_name, :last_name, :sites_attributes, 
  								:email, 
  								:admin, 
  								:password, 
  								:password_confirmation, 
  								:remember_me,
                  :site_ids,
                  :merchant_attributes

  # Associations
  has_many :appointments
  has_many :shifts
  has_many :sites, through: :appointments 
  has_one :merchant

  accepts_nested_attributes_for :sites
  accepts_nested_attributes_for :appointments
  accepts_nested_attributes_for :merchant
  def put_cashouts(cashouts)
    if cashouts.present?
      cashouts.each do |cashout|
        self.merchant.merchant_cashouts.new(cashout_sum: cashout).save
      end
    end

  end
  private 
    def new_merchant
      self.build_merchant.save unless self.merchant.present?
    end
end
