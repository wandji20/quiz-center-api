class Quiz < ApplicationRecord
  before_save :downcase_title

  TITLES = %w[mathematics geography history sports].freeze

  validates :title, presence: true, uniqueness: true

  has_many :questions, dependent: :destroy

  default_scope { includes(:questions).order(title: :desc) }

  private

  def downcase_title
    self.title = title.downcase if title.present?
  end
end
