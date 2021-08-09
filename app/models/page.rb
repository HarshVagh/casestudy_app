class Page < ApplicationRecord
    belongs_to :casestudy

    validates :casestudy_id, presence: true
    validates :body, presence: true
    validates :body, length: {minimum:10, maximum:3000}
    
end