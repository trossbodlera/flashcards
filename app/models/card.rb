# frozen_string_literal: true

# Card
class Card < ApplicationRecord
  belongs_to :user

  validates :original_text, :translated_text, presence: true
  validates :original_text, :translated_text, length: { in: 1..128 }
  validate :validate_not_equal

  scope :overdue_time, -> { where('review_date <= ?', DateTime.now) }

  def self.random
    overdue_time.order('RANDOM()').take
  end

  def validate_not_equal
    return unless original_text && translated_text

    if original_text.downcase.strip == translated_text.downcase.strip
      errors.add(:original_text,
                 I18n.t('cards.errors.unique'))
    end
  end
end
