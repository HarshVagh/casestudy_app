class RoleUser < ApplicationRecord
    belongs_to :user
    belongs_to :role

    validates :user_id, presence: true
    validates :role_id, presence: true
    validates :user_id, uniqueness: { scope: :role_id }
end