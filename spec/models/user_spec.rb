require 'rails_helper'
RSpec.describe User, type: :model do
  before(:each) do
    @user = create :user
  end

  it 'should save valid user' do
    expect(@user.valid?).to eq true
    expect(@user.save).to eq true
  end

  it 'no error messages for valid user' do
    expect(@user.errors.messages.blank?).to eq true
  end

  it 'should not save user without contact number' do
    user = build(:user, contact_number: nil)
    expect(user.valid?).to eq false
    expect(user.save). to eq false
  end

  it 'should not save user without valid contact number' do
    user = build(:user, contact_number: 'abcd')
    expect(user.valid?).to eq false
    expect(user.save). to eq false
  end

  it 'should not save without email' do
    user = build(:user, email: nil)
    expect(user.valid?).to eq false
  end

  it 'should not save user without valid email' do
    user = build(:user, email: "josh123")
    expect(user.valid?).to eq false
    expect(user.save). to eq false
  end

  it 'password and confirm password does not match' do
    user = build(:user, email: "xyz@josh.com", password:'1234', password_confirmation: '1222')
    expect(user.password_match?).to eq false
  end

  it 'should save if password and confirm password match' do
    user = build(:user, email: "joshemail@josh.com", contact_number: '9123456789',
      password: '1234', password_confirmation: '1234')
    expect(user.password_match?).to eq true
    expect(user.save). to eq true
  end

end
