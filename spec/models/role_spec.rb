require 'rails_helper'
require 'factories/role'

RSpec.describe Role, type: :model do
  before(:each) do
    @role = create :role
  end
  it 'should save valid role record' do
    expect(@role.valid?).to eq true
    expect(@role.save).to eq true
  end
end
