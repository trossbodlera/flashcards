# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }
end
