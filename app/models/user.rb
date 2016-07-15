class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter, :naver]

  acts_as_sequenced

  # mount
  mount_uploader :image, UserImageUploader
  mount_uploader :card, UserCardUploader

  def self.parse_omniauth(data)
    {provider: data['provider'], uid: data['uid'], email: data['info']['email'], image: data['info']['image'], name: data['info']['name']}
  end

  def self.find_or_initialize_for_omniauth(parsed_data)
    user = User.find_or_initialize_by(provider: parsed_data[:provider], uid: parsed_data[:uid]) do |user|
      user.email = parsed_data[:email]
      user.name = parsed_data[:name]
      user.password = Devise.friendly_token[0,20]
      user.remote_image_url = parsed_data[:image]
    end
    user.remember_me = parsed_data[:remember_me]
    user
  end

  def admin?
    %w(account@parti.xyz rest515@parti.xyz berry@parti.xyz dalikim@parti.xyz lulu@parti.xyz qus@parti.xyz muni@parti.xyz foroso@gmail.com).include? email
  end
end