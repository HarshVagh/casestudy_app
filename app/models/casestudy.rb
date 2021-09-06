class Casestudy < ApplicationRecord
    has_many :pages
    
    has_many :casestudy_users
    has_many :users, through: :casestudy_users

    has_many :questions

    belongs_to :contentcreator, class_name: "User"

    validates :name, presence: true
    validates :name, length: {minimum:3, maximum:30}
    validates :duration, presence: true
    validates :duration, numericality: {less_than: 250}
    validates :scale, presence: true
    validates :scale, numericality: {greater_than_or_equal_to: 6, less_than_or_equal_to: 10}
    validates :contentcreator_id, presence: true
    
end
