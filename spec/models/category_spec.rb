# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Category, type: :model do
  before(:each) do
    @category = create :category
  end
  it 'should save valid category' do
    expect(@category.valid?).to eq true
    expect(@category.save).to eq true
  end

  it 'no error messages for valid category' do
    expect(@category.errors.messages.blank?).to eq true
  end

  it 'should not save without category name' do
    category = build(:category, category_name: nil)
    expect(category.valid?).to eq false
  end

  it 'should not save without category description' do
    category = build(:category, category_description: nil)
    expect(category.valid?).to eq false
    expect(category.save).to eq false
  end

  it 'should not save without category picture' do
    category = build(:category, picture: nil)
    expect(category.valid?).to eq false
    expect(category.save).to eq false
  end

  it 'should save sub_category' do
    expect(@category.valid?).to eq true
    sub_category = build(:category, primarycategory_id: @category.id)
    expect(sub_category.save).to eq true
  end

end
