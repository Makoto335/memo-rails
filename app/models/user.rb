# frozen_string_literal: true
class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  before_create :default_avatar

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
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,128}+\z/i
  validates :name, presence: true, length: { maximum: 60 }
  validates :email,
            presence: true,
            length: {
              maximum: 254,
            },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
            }
  validates :password,
            length: {
              maximum: 254,
            },
            format: {
              with: VALID_PASSWORD_REGEX,
            },
            allow_blank: true
  validates :avatar,
            content_type: {
              in: %i[png jpg jpeg gif],
              message: 'png, jpg, jpegいずれかの形式にして下さい',
            },
            size: {
              less_than: 2.megabytes,
              message: 'サイズを5M以下にしてください',
            }
  validates :date_of_birth, presence: true
  validate :valid_date_format

  def avatar_url
      resized_avatar = avatar.variant(resize_to_limit: [400, 400])
      url_for(resized_avatar)
  end

  private

  def valid_date_format
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "未来の日付は使えません")
    end
  end

  def default_avatar
    if !self.avatar.attached? && self.new_record?
      self.avatar.attach(
        io:
          File.open(
            Rails.root.join(
              'app',
              'assets',
              'images',
              'blank-profile-picture_640.png',
            ),
          ),
        filename: 'blank-profile-picture_640.png',
        content_type: 'image/png',
      )
    end
  end
end
