class Gig < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true

  scope :all_ascending,        -> { order(date: :asc) }
  scope :all_descending,       -> { order(date: :desc) }
  scope :published_ascending,  -> { where(published: true).order(:date) }
  scope :published_descending, -> { where(published: true).order(date: :desc) }
end
