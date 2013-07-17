require 'spec_helper'

describe "rows/edit" do
  before(:each) do
    @row = assign(:row, stub_model(Row))
  end

  it "renders the edit row form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", row_path(@row), "post" do
    end
  end
end
