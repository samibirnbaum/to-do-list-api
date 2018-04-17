class User < ApplicationRecord
    #@username
    #@password
    #@email
    has_many :lists

    validates :username, :password, :email, presence: true
    
    validates :username, uniqueness: true
    validates :email, uniqueness: true

    validates :password, length: { in: 6..20 }
end
