require 'rails_helper'

RSpec.describe Item, type: :model do
  
  let(:item) { create(:item) }

  describe 'attributes' do
    it 'has name complete list_id attributes' do
      expect(item).to have_attributes(name: "The item to be complete", complete: false, list_id: 1)
    end
  end

  describe 'model validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:list_id) }
    it { should validate_inclusion_of(:complete).in_array([true, false]) }
   
    it { should belong_to(:list) }
  end
end
