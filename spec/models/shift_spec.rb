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
#  comment     :text
#  percent     :integer
#  accept_at   :datetime
#  cancel_at   :datetime
#

require 'spec_helper'

describe Shift do
   let(:site) do
    stub_model Site, id: 1, shiftstatus: false
   end

  it "shift has till and balance" do
    shift = Shift.create!(site_id: 1, balance: 2000, till: 1000)

    expect(Shift.first.till).to be_true 
    expect(Shift.first.balance).to be_true 
  end

  it "shift accepting" do
   
   shift = Shift.new(site_id: 1)
   if shift.save
     site.shiftstatus = true
   end
   site.shiftstatus == be_true
  end
end
