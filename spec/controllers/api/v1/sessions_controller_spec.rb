require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  describe "POST create" do
    before(:each) { @user =  FactoryGirl.create(:user) }
    
    context "when the credential are correct" do
      before(:each) do
        credentials = { email: @user.email, password: "12345678" }
        post :create, { session: credentials }
      end  
      
      it "returns the user record of corresponding given credentials" do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token  
      end
      
      it { should respond_with 200 }
    end
    
    context "when the credential are incorrect" do
      before(:each) do
        credentials = { email: @user.email, password: "1234567890" }
        post :create, { session: credentials }
      end  
      
      it "returns a json with error" do
        expect(json_response[:errors]).to eql("Invalid email or password")  
      end
      
      it { should respond_with 422 }
    end
    
  end

end
