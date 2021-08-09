class Question < ApplicationRecord
    belongs_to :casestudy
    
    has_many :user_responses
    has_many :question_traits

    validates :casestudy_id, presence: true
    validates :body, presence: true
    validates :body, length: {minimum:10, maximum:1000}
end