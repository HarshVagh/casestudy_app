class Casestudy < ApplicationRecord
    has_many :pages
    
    has_many :casestudy_users
    has_many :users, through: :casestudy_users

    has_many :questions

    belongs_to :contentcreator, class_name: "User"

    validates :duration, presence: true
    validates :scale, presence: true
    validates :scale, length: {maximum:10}
    validates :contentcreator_id, presence: true
    
end
