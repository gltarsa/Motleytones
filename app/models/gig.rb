class Gig < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true

  scope :published, -> { where(published: true) }
end
