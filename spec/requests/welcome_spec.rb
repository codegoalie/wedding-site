require 'spec_helper'

describe "welcome requests" do

  describe 'GET root' do
    it "has the What's Going On? header" do
      get '/'
      response.should have_selector('h1', content: "What's Going On?")
    end
  end
end
