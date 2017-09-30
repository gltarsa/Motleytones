# frozen_string_literal: true

module Ahoy
  class Event < ActiveRecord::Base
    self.table_name = "ahoy_events"

    belongs_to :visit, optional: true
    belongs_to :user, optional: true
  end
end
