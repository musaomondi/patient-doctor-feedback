class Patient < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50  }
  validates :age, presence: true
  validates :gender, presence: true
  validates :town, presence: true, length: { maximum: 20  }
  validates :county, presence: true, length: { maximum: 20  }
end
