require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { create(:list) } #builds a list object from the factory

  describe 'attributes' do
    it 'should have name private and user_id attributes' do
      expect(list).to have_attributes(name: "The Sunday List", private: false, user_id: 1)
    end
  end

  describe 'model validations' do
		
		it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_inclusion_of(:private).in_array([true, false]) }
   
    it { should belong_to(:user) }
		it { should have_many(:items) }
	end
end
