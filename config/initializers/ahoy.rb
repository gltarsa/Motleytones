Ahoy.api = true
Ahoy.server_side_visits = false

class Ahoy::Store < Ahoy::DatabaseStore
  def visit_model
    Visit
  end

  # customize here
  # By default, Ahoy does not count visits by robots.  It mistakes test
  # mode as a robot.  This is a patch to #exclude? to allow "robots"
  def exclude?
    super && !Rails.env.test?
  end
end
