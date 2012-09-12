module Utilities

  # Formats a date string Sakai-style.
  # Useful for verifying creation dates and such.
  #
  # Supplied variable must be of of the Time class.
  def make_date(time_object)
    month = time_object.strftime("%b ")
    day = time_object.strftime("%d").to_i
    year = time_object.strftime(", %Y ")
    mins = time_object.strftime(":%M %P")
    hour = time_object.strftime("%l").to_i
    return month + day.to_s + year + hour.to_s + mins
  end

  # Shorthand method for making a data object for testing.
  def make data_object_class, opts={}
    data_object_class.new @browser, opts
  end

end