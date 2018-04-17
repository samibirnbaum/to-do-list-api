class Item < ApplicationRecord
  #@name
  #@complete
  #@list_id
  belongs_to :list

  validates :name, :list_id, presence: true
  validates_inclusion_of :complete,:in => [true, false]
end
