class QuestionTrait < ApplicationRecord
    belongs_to :trait
    belongs_to :question
    has_many :assessor_responses

    validates :trait_id, presence: true
    validates :question_id, presence: true
    validates :trait_id, uniqueness: { scope: :question_id }
end