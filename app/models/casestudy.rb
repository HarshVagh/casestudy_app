class Casestudy < ApplicationRecord
    has_many :pages
    
    has_many :casestudy_users
    has_many :users, through: :casestudy_users

    has_many :questions

    validates :duration, presence: true
    validates :scale, presence: true
    validates :scale, length: {maximum:10}
    
end
