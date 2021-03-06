class User < ApplicationRecord
  attr_accessor :remember_token
  # belongs_to :user_type, :foreign_key => :user_type_id
  has_many :user_patients
  has_many :patients, :through => :user_patients
  before_save { email.downcase!  }
  validates :first_name, presence: true, length: { maximum: 30  }
  validates :last_name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255  },
                    format: { with: VALID_EMAIL_REGEX  },
                    uniqueness: { case_sensitive: false  }
  has_secure_password
  validates :password, length: { minimum: 6  }
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
