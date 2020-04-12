require 'rails_helper'

RSpec.describe UserAnimation, type: :model do
  before(:each) do
    @user_animation = create :user_animation
  end

  it 'should save valid user animation' do
    expect(@user_animation.valid?).to eq true
    expect(@user_animation.save).to eq true
  end

  it 'no error messages for valid user animation' do
    @user_animation.valid?
    expect(@user_animation.errors.messages.blank?).to eq true
  end

  it 'should not save without start date' do
    user_animation = build(:user_animation, start_date: nil)
    expect(user_animation.valid?).to eq false
    expect(user_animation.save).to eq false
  end

  it 'should not save without valid end date' do
    user_animation = build(:user_animation, end_date: nil)
    expect(user_animation.valid?).to eq false
    expect(user_animation.save).to eq false
  end

  it 'should not save without location' do
    user_animation = build(:user_animation, location: nil)
    expect(user_animation.valid?).to eq false
    expect(user_animation.save).to eq false
  end

end
