class Gig < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true

  scope :published_ascending, -> { where(published: true).order(:date) }
  scope :published_descending, -> { where(published: true).order(date: :desc) }
end
