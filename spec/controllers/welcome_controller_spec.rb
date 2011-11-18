require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it 'should set the correct title' do
      get :index
      assigns(:title).should eq("What's Going On?")
    end
  end

  describe "GET 'pics'" do
    it "returns http success" do
      get :pics
      response.should be_success
    end

    it 'should set the correct title' do
      get :pics
      assigns(:title).should eq("Picture Gallery")
    end
  end

  describe "GET 'game'" do
    it "returns http success" do
      get :game
      response.should be_success
    end

    it 'should set the correct title' do
      get :game
      assigns(:title).should eq("Match Game")
    end
  end

end
