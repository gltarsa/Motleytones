class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  # customize here
  # By default, Ahoy does not count visits by robots.  It mistakes test
  # mode as a robot.  This is a patch to #exclude? to allow "robots"
  def exclude?
    super && !Rails.env.test?
  end
end
