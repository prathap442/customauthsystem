require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is expected to validate the presence of name' do
    is_expected.to validate_presence_of(:name)
  end
  it 'is_expected to  validatee the presence of mobile' do
    is_expected.to validate_presence_of(:mobile)
  end
  it 'is expected to validate the presence of password' do
    is_expected.to validate_presence_of(:password)
  end
  it 'is expected to validate uniqueness of mobile' do
    should validate_uniqueness_of(:mobile)
  end
end
