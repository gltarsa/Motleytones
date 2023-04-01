# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    define_gigs
  end

  def schedule
    define_gigs
  end

  private

  def define_gigs
    @active_gigs = Gig.active.ascending
    @expired_gigs = Gig.expired.descending
  end
end
