class AssessorResponse < ApplicationRecord
    belongs_to :question_trait
    belongs_to :casestudy_user
    belongs_to :user
    belongs_to :assessor, class_name: "User"

    validates :question_trait_id, presence: true
    validates :casestudy_user_id, presence: true
    validates :user_id, presence: true
    validates :assessor_id, presence: true
    validates :rating, presence: true

    validates :assessor_id, numericality: { other_than: :user_id }
end