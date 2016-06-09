require 'rails_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  
  subject { @user }
  
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:auth_token) }
  
  it { is_expected.to be_valid }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value("example@domian.com").for(:email) }
  it { should validate_uniqueness_of(:auth_token) }
  
  describe "#generate_authentication_token!" do
    it "generates a authentication token" do
      Devise.stub(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end
    
    it "generates another token when one is already taken" do
      @existing_user = FactoryGirl.create(:user, auth_token:"auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql @existing_user.auth_token
    end
      
  end
  
end