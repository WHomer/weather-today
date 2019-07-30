require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  it 'creates a user' do
    User.create!(email: 'test@email.com',
      password: 'a',
      password_confirmation: 'a'
    )
    expect(User.last.email).to eq('test@email.com')
  end
end
