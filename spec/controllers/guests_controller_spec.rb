require 'spec_helper'

describe GuestsController, 'index' do

  describe 'without logged in user' do
    describe "GET 'index'" do
      it "should redirect to sign in page" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe 'with logged in user' do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factory.create(:user)
      #user.confirm!
      sign_in user
    end

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        response.should be_success
      end

      it 'should set the correct title' do
        get :index
        assigns(:title).should eq("Guest List")
      end
    end

  end
end
describe GuestsController, 'show' do
  describe "GET 'show'" do
    describe 'without logged in user' do
      it 'should redirect to sign in wihtout finding' do
        Guest.should_not_receive(:find)
        get :show, id: 1
        response.should redirect_to(new_user_session_path)
      end
    end

    describe 'with logged in user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = Factory.create(:user)
        #user.confirm!
        sign_in user

      end

      it 'should find a guest and be successful' do
        guest = Factory.create(:guest)
        Guest.should_receive(:find).and_return(guest)
        get :show, id: 1
        response.should be_success
      end
    end
  end
end
