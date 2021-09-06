class CasestudyUser < ApplicationRecord
    belongs_to :user
    belongs_to :casestudy
    belongs_to :assessor, class_name: "User"
    has_many :user_responses
    has_many :assessor_responses

    validates :casestudy_id, presence: true
    validates :user_id, presence: true
    validates :assessor_id, presence: true

    validates :assessor_id, numericality: { other_than: :user_id }

    validates :casestudy_id, uniqueness: { scope: :user_id }
    
    validates :status, presence: true
    validates :status, length: {minimum:3, maximum:30}
    validates :status, format: {with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "Invalid Status string"}
    validates_inclusion_of :status, in: [ 'pending', 'ongoing', 'completed', 'assessed' ], message: 'enter valid status'


    validates :time_elaspsed, presence: true

end