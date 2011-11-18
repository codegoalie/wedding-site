require 'spec_helper'

describe "welcome/index.html.haml" do
  it "should have a news_list" do
    render
    rendered.should have_selector('ul#news_list')
  end
end
