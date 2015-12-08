class GigUniquenessValidator < ActiveModel::Validator
  def validate (record)
    if Gig.find_by(date: record.date, name: record.name)
      record.errors[:base] << "record with same date and name already exists"
    end
  end
end

class Gig < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true
  validates_with GigUniquenessValidator

  scope :all_ascending,        -> { order(date: :asc) }
  scope :all_descending,       -> { order(date: :desc) }
  scope :published_ascending,  -> { where(published: true).order(:date) }
  scope :published_descending, -> { where(published: true).order(date: :desc) }
end
