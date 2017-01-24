# frozen_string_literal: true
class Gig < ApplicationRecord
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true
  validates :name, uniqueness: { scope: :date, message: "record with same date and name already exists" }

  scope :published,  -> { where(published: true) }
  scope :ascending,  -> { order(date: :asc) }
  scope :descending, -> { order(date: :desc) }
  scope :expired,    -> { where("date + days < ?", Date.today) }
  scope :active,     -> { where("date + days >= ?", Date.today) }
end
