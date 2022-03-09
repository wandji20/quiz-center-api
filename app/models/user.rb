class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { in: 2..50 }
  validates :email,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX },
            length: { maximum: 255 }
  validates :password, :password_confirmation, presence: true, length: { in: 6..72 }

  has_secure_password

  has_many :answered_questions

  def unanswered_questions_for_quiz
    answered_question_ids = Question.joins(:answered_questions).pluck(:id)
    Question.where.not(id: answered_question_ids)
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end