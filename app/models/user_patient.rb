class UserPatient < ApplicationRecord
  include ActionView::Helpers::TextHelper
  # attr_accessor :amount, :comment_type_id, :comments, :patient_id, :user_id, :archive
  belongs_to :user
  belongs_to :patient
  belongs_to :comment_type, :foreign_key => :comment_type_id

  def created_at_string
    if !created_at.blank? && created_at != nil
      created_at.strftime("%d-%m-%Y")
    end
  end

  def comments_html
    if !created_at.blank? && created_at != nil
      simple_format(comments)
    end
  end

  def isArchive?
    if archive == SessionsHelper::ARCHIVE
      return true
    else
      return false
    end
  end
end
