require 'rails_helper'
include Devise::TestHelpers
RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each){ request.headers['Accept'] = "application/vnd.marketplace.v1"}
  
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get :show, id: @user.id, format: :json 
    end
    
    it "should return the user details of the sender" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end
    
    it { should respond_with 200 }
    
  end
end
