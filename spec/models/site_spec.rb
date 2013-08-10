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

require 'spec_helper'

describe Site do
#  pending "add some examples to (or delete) #{__FILE__}"
end
