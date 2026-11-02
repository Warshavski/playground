# frozen_string_literal: true

class Book < ApplicationRecord
  include AASM

  belongs_to :publisher
  belongs_to :user

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres

  validates :title, presence: true
  validates :published_in, presence: true
  validates :state, presence: true

  aasm column: :state do
    state :draft, initial: true
    state :pending_review
    state :published
    state :rejected

    event :submit_for_review do
      transitions from: :draft, to: :pending_review
    end

    event :publish do
      transitions from: :pending_review, to: :published
    end

    event :reject do
      transitions from: :pending_review, to: :rejected
    end

    event :revise do
      transitions from: :rejected, to: :draft
    end
  end
end
