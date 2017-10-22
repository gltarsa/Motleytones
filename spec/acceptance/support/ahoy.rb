# frozen_string_literal: true

# Ahoy has code to ignore bots, which ignores the browser used for Acceptance testing.
# This monkey patch adds check to NOT ignore bots when testing.
module Ahoy
  class Store
    def exclude?
      super && !Rails.env.test?
    end
  end
end
