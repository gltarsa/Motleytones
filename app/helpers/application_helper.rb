# frozen_string_literal: true

module ApplicationHelper
  def canceled(gig)
    return false unless gig

    gig.name.downcase.match?(/cancell*ed[\W]/i)
  end
end
