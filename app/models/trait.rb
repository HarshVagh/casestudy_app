class Trait < ApplicationRecord
    has_many :question_trait
    has_many :questions, through: :question_trait

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :name, length: {maximum:30}
end