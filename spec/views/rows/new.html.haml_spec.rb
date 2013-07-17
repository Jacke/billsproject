require 'spec_helper'

describe "rows/new" do
  before(:each) do
    assign(:row, stub_model(Row).as_new_record)
  end

  it "renders new row form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rows_path, "post" do
    end
  end
end
