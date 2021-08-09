class Role < ApplicationRecord
    has_many :role_users
    has_many :users, through: :role_users 

    validates :name, presence: true
    validates :name, length: {minimum:3, maximum:30}
    validates :name, format: {with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "Invalid Name"}

end