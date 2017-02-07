class User < ApplicationRecord
  validates :first_name, presence: true, length: { maximum: 30  }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255  }
end
