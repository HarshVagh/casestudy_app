class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :role_users
  has_many :roles, through: :role_users
  has_many :user_responses
  has_many :casestudy_users
  has_many :casestudies, through: :casestudy_users
  has_many :assessor_responses

  validates :name, presence: true
  validates :name, length: {minimum:3, maximum:30}
  validates :name, format: {with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "Invalid Name"}

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, length: {maximum:50}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Invalid Email Address"}

  validates :password, presence: true
  validates :password, length: {minimum:6, maximum:20}

  after_create :add_new_role

  private
    def add_new_role
        role_user = RoleUser.new(role_id: Role.find_by(name: "candidate").id, user_id: self.id)
        role_user.save
    end

end
