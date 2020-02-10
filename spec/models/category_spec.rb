# frozen_string_literal: true

require 'rails_helper'
require 'factories/categories'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = create :category
  end
  it 'should save valid category record' do
    expect(@category.valid?).to eq true
    expect(@category.save).to eq true
  end

  it 'should not save without valid category description' do
    @category = build(:category, category_description: nil)
    expect(@category.valid?).to eq false
  end

  it 'should not save without valid category picture' do
    @category = build(:category, picture: nil)
    expect(@category.valid?).to eq false
  end

  it 'should give error message' do
    @category.valid?
    expect(@category.errors.messages.blank?).to eq true
  end

end