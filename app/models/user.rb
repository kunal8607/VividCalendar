# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :calendars, dependent: :destroy
  has_many :events, through: :calendars

  def self.from_omniauth(auth)
    user = User.where(provider: auth.try(:provider) || auth['provider'], uid: auth.try(:uid) || auth['uid']).first
    if user
      user
    else
      registered_user = User.where(provider: auth.try(:provider) || auth['provider'], uid: auth.try(:uid) || auth['uid']).first || User.where(email: auth.try(:info).try(:email) || auth['info']['email']).first
      if registered_user
        unless registered_user.provider == (auth.try(:provider) || auth['provider']) && registered_user.uid == (auth.try(:uid) || auth['provider'])
          registered_user.update_attributes(provider: auth.try(:provider) || auth['provider'], uid: auth.try(:uid) || auth['uid'])
        end
        return registered_user
      else
        user = User.new(provider: auth.try(:provider) || auth['provider'], uid: auth.try(:uid) || auth['uid'])
        user.email = auth.try(:info).try(:email) || auth['info']['email']
        user.password = Devise.friendly_token[0, 20]
        user.first_name = auth.info.name.split(' ')[0]
        user.last_name = auth.info.name.split(' ')[1]
        user.access_token = auth.credentials.token
        user.expires_at = auth.credentials.expires_at
        user.refresh_token = auth.credentials.refresh_token
        user.save
        puts user
      end
      user
    end
  end

  def expired?
    expires_at < Time.current.to_i
  end

  def name
    "#{first_name} #{last_name}"
  end
end
