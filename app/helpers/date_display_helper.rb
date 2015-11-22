module DateDisplayHelper

  def date_range(date, num)
    base = date.strftime("%b %-d")
    last_day = date + num

    return base if num == 1

    if date.month == last_day.month
      base + last_day.strftime("-%-d")
    else
      base + last_day.strftime("-%b %-d")
    end
  end
end
