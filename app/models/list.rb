class List < ApplicationRecord
  #@name
  #@private
  #@user_id
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, :user_id, presence: true
  validates_inclusion_of :private,:in => [true, false]
end
