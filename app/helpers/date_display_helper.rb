# frozen_string_literal: true

module DateDisplayHelper
  def date_range(date, num)
    base = date.strftime("%b %-d") # "mmm dd"
    last_day = date + num - 1

    return base if num == 1

    return base + last_day.strftime("-%-d") if in_same_month(date, last_day) # "mmm dd-dd"

    base + last_day.strftime("-%b %-d") # "mmm dd-mmm dd"
  end

  def date_thru_range(date, num)
    base = date.strftime("%d-%b-%y")
    last_day = date + num - 1

    return base if num == 1

    base + " thru " + last_day.strftime("%d-%b-%y")
  end

  private

  def in_same_month(start_date, end_date)
    start_date.month == end_date.month
  end
end
