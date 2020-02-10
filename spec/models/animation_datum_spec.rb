# frozen_string_literal: true

require 'rails_helper'
require 'factories/animation_data'

RSpec.describe AnimationData, type: :model do
  before(:each) do
    @animation_data = create :animation_data
  end
  it 'should save valid animation data record' do
    expect(@animation_data.valid?).to eq true
    expect(@animation_data.save).to eq true
  end

  it 'should not save without valid animation json' do
    @animation_data = build(:animation_data, animation_json: nil)
    expect(@animation_data.valid?).to eq false
  end

  it 'should not save without valid animation image' do
    @animation_data = build(:animation_data, picture: nil)
    expect(@animation_data.valid?).to eq false
  end

  it 'should not save without valid animation price' do
    @animation_data = build(:animation_data, animation_price: nil)
    expect(@animation_data.valid?).to eq false
  end

  it 'should give error message' do
    @animation_data.valid?
    expect(@animation_data.errors.messages.blank?).to eq true
  end

end