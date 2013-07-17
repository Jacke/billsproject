require 'spec_helper'

describe "rows/index" do
  before(:each) do
    assign(:rows, [
      stub_model(Row),
      stub_model(Row)
    ])
  end

  it "renders a list of rows" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
