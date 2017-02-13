class Patient < ApplicationRecord
  has_many :user_patients
  has_many :users, :through => :user_patients

  validates :name, presence: true, length: { maximum: 50  }
  validates :age, presence: true
  validates :gender, presence: true
  validates :town, presence: true, length: { maximum: 20  }
  validates :county, presence: true, length: { maximum: 20  }
  validates :phone_number, presence: true

  def date_of_birth_string
    if !date_of_birth.blank? && date_of_birth != nil
      date_of_birth.strftime("%d-%m-%Y")
    end
  end

  def created_at_string
    if !created_at.blank? && created_at != nil
      created_at.strftime("%d-%m-%Y")
    end
  end
end
