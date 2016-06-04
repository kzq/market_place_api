require 'rails_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  
  subject { @user }
  
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  
  it { is_expected.to be_valid }
  
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value("example@domian.com").for(:email) }
  
  
end