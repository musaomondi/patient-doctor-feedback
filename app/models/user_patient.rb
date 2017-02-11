class UserPatient < ApplicationRecord
  include ActionView::Helpers::TextHelper
  attr_accessible :amount, :comment_type_id, :comments, :patient_id, :user_id, :archive
  belongs_to :user
  belongs_to :patient
  belongs_to :comment_type, :foreign_key => :comment_type_id
end
