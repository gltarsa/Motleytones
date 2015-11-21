class Gig < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 10 }
  validates :date, presence: true

  # plan:
  # Have an "Manage Gigs" link in the navigation
  # Restore "Performance Schedule" and "Home" to display output as it will look to users.
  # Edit Gigs will display published status & edit/delete buttons."
  # Question: should the "Add Gig" operation be put on this page as well--with it being removed from the Navigation screen?
  #   Process flow would be Nav->Manage Gigs then Add Gig or Edit/Delete specific gig.
  #       Control from Delete would then return to the Gig Management page.
  #       Control from the "Show" page would have an additional button to allow return to the Gig Management Page
  def self.process_markup
    binding.pry
  end
end
