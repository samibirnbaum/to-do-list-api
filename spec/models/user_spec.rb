require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { create(:user) }

	describe 'attribures' do
		it 'has attributes user password and email' do
			expect(user).to have_attributes(username: "SamiB", email: "sami@sami.com", password: "password")
		end
	end

	describe 'model validations' do
		
		it { should validate_presence_of(:username) }
		it { should validate_presence_of(:email) }
		it { should validate_presence_of(:password) }

		it { should validate_uniqueness_of(:username) }
		it { should validate_uniqueness_of(:email) }

		it {should validate_length_of(:password).is_at_least(6).is_at_most(20)}
		
		it { should have_many(:lists) }
	end
end
