# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#FIGVAPERB
class User < ApplicationRecord

validates :username,:session_token, presence:true, uniqueness:true
validates :password_digest, presence:true
validates :password, length:{minimum:6, allow_nil:true}

before_validation :ensure_session_token

attr_reader :password

  has_many :subs,
    inverse_of: :moderators


  def self.find_by_credentials(username,password)
    user = User.find_by(username:username)
    user && user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

  def reset_session_token!
      self.session_token = generate_unique_session_token
      self.save!
      self.session_token
  end

  def generate_unique_session_token
    token = SecureRandom::urlsafe_base64
    while User.exists?(session_token:token)
      token = SecureRandom::urlsafe_base64
    end
    token
  end
end
