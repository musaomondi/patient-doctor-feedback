class Patient < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true
  validates :gender, presence: true
  validates :town, presence: true
  validates :county, presence: true
end
