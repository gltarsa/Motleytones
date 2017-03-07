# Ahoy has code to ignore bots, which ignores the browser used for Spinach testing.
# This monkey patch adds check to NOT ignore bots when testing.
class Ahoy::Store
  def exclude?
    super && !Rails.env.test?
  end
end
