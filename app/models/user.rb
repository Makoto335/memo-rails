# frozen_string_literal: true
class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :memos
  has_one_attached :avatar
  validates :name, presence: true
  validates :name, presence: true, length: { maximum: 60 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {
              maximum: 254,
            },
            format: {
              with: VALID_EMAIL_REGEX,
            }
  def avatar_url
    avatar.attached? ? url_for(avatar) : nil
  end
end
