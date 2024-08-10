# frozen_string_literal: true

module ApplicationHelper
  def canceled(gig)
    return false unless gig

    gig.name.downcase.include?('canceled:') || gig.name.downcase.include?('cancelled:')
  end
end
