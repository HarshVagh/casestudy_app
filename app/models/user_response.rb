class UserResponse < ApplicationRecord
    belongs_to :question
    belongs_to :casestudy_user
    belongs_to :user

    validates :question_id, presence: true
    validates :casestudy_user_id, presence: true
    validates :user_id, presence: true
    validates :question_id, uniqueness: { scope: :casestudy_user_id }

    validates :response, length: {maximum:1000}
end