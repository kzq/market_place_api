require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get :show, id: @user.id 
    end
    
    it "should return the user details of the sender" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end
    
    it { should respond_with 200 }
    
  end
  
  describe "POST #create" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    context "When user is created successfully" do
      before(:each) do
        @user_valid_attributes = FactoryGirl.attributes_for(:user)
        post :create, { user: @user_valid_attributes }
      end
      
      it "Creates new user and sends back user details in json" do
        user_response = json_response 
        expect(user_response[:email]).to eql(@user_valid_attributes[:email])
      end
    
      it { should respond_with 201 }
    end
    
    context "When user is not created" do
      before(:each) do
        @user_invalid_attributes = { password: "12345678", password_confirmation: "12345678" }
        post :create, {user: @user_invalid_attributes}
      end  
      
      it "renders an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "renders the json error on why user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include("can't be blank")  
      end 
      
      it { should respond_with 422 } 
    end
  end
  
  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    context "When user details are updated successfully" do
      before(:each) do
        patch :update, { id: @user.id, user: { email:"mynewemail@yahoo.com" } }
      end
      
      it "renders the json with updated user details" do
        user_response = json_response 
        expect(user_response[:email]).to eql("mynewemail@yahoo.com")
      end
    
      it { should respond_with 200 }
    end
    
    context "When details are not updated" do
      before(:each) do
        patch :update, { id: @user.id, user: { email:"mynewemail.com" } }
      end  
      
      it "renders an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "renders the json error on why user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include("is invalid")  
      end 
      
      it { should respond_with 422 } 
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      delete :destroy, { id: @user.id }
    end

    it { should respond_with 204 }
  end
end
