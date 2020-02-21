require 'rails_helper'
# require 'factories/user_animations'

RSpec.describe UserAnimation, type: :model do
  before(:each) do
    @user_animation = create :user_animation
  end
  it 'should save valid user animation record' do
    expect(@user_animation.valid?).to eq true
    expect(@user_animation.save).to eq true
  end

  it 'should not save without valid start date' do
    @user_animation = build(:user_animation, start_date: nil)
    expect(@user_animation.valid?).to eq false
  end

  it 'should not save without valid end date' do
    @user_animation = build(:user_animation, end_date: nil)
    expect(@user_animation.valid?).to eq false
  end

  it 'should not save without valid location' do
    @user_animation = build(:user_animation, location: nil)
    expect(@user_animation.valid?).to eq false
  end

  it 'should give error message' do
    @user_animation.valid?
    expect(@user_animation.errors.messages.blank?).to eq true
  end

end
