require 'rails_helper'
# require 'factories/users'

RSpec.describe User, type: :model do
  before(:each) do
    @user_data = create :user
  end
  it 'should save valid user data record' do
    expect(@user_data.valid?).to eq true
    expect(@user_data.save).to eq true
  end

  it 'should not save without valid contact number' do
    @user_data = build(:user, contact_number: nil)
    expect(@user_data.valid?).to eq false
  end

  it 'should not save without valid email' do
    @user_data = build(:user, email: nil)
    expect(@user_data.valid?).to eq false
  end

  it 'should give error message' do
    @user_data.valid?
    expect(@user_data.errors.messages.blank?).to eq true
  end

  # it 'should not have blank confirm password' do
  #   @user_data = build(:user, confirmation_token: nil)
  #   expect(@user_data.valid?).to eq false
  # end


end
