class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :recoverable, :confirmable, :rememberable,
         :validatable

  has_many :notifications, as: :recipient
  has_many :messages
  has_many :rooms

  enum role: %i[user admin]
  validates :password, presence: { value: true, message: 'Password can not blank' },
                       confirmation: { value: true, message: 'Password does not match' }
  validates :phone, numericality: { only_integer: true, message: 'Phone is not a number' }
  validates :email, presence: { value: true, message: 'Email can not blank' },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Email is not correct' },
                    length: { maximum: 100 }, uniqueness: { value: true, message: 'Email has already been taken' }
end
