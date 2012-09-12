class EventObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :title, :month, :day, :year, :start_hour, :start_minute,
                :start_meridian, :duration_hours, :duration_minutes, :end_hour,
                :end_minute, :end_meridian, :message, :site, :link

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :title=>random_alphanums,
        :month=>in_15_minutes[:month_str],
        :day=>in_15_minutes[:day],
        :year=>in_15_minutes[:year],
        :start_hour=>in_15_minutes[:hour],
        :start_minute=>in_15_minutes[:minute],
        :start_meridian=>in_15_minutes[:meridian],
        :duration_hours=>nil,
        :duration_minutes=>nil,
        :end_hour=>nil,
        :end_minute=>nil,
        :end_meridian=>nil,
        :message=>random_multiline(400,20),
        :site=>"placeholder"
    }
    options = defaults.merge(opts)

    @title=options[:title]
    @month=options[:month]
    @day=options[:day]
    @year=options[:year]
    @start_hour=options[:start_hour]
    @start_minute=options[:start_minute]
    @start_meridian=options[:start_meridian]
    @duration_hours=options[:duration_hours]
    @duration_minutes=options[:duration_minutes]
    @end_hour=options[:end_hour]
    @end_minute=options[:end_minute]
    @end_meridian=options[:end_meridian]
    @message=options[:message]
    @site=options[:site]

  end

  def create
    home = my_workspace.open_my_site_by_name @site
    calendar = home.calendar
    add_event = calendar.add
    add_event.message=@message
    add_event.title=@title
    add_event.month=@month
    add_event.day=@day
    add_event.year=@year
    add_event.start_hour=@start_hour
    add_event.start_minute=@start_minute
    add_event.start_meridian=@start_meridian
    if @end_hour == nil && @duration_hours == nil
      @duration_hours = add_event.hours
      @duration_minutes = add_event.minutes
      @end_hour = add_event.end_hour
      @end_minute = add_event.end_minute
      @end_meridian = add_event.end_meridian
    elsif @end_hour == nil
      add_event.hours=@duration_hours
      add_event.minutes=@duration_minutes
      @end_hour = add_event.end_hour
      @end_minute = add_event.end_minute
      @end_meridian = add_event.end_meridian
    elsif @duration_hours == nil

    else

    end

    calendar = add_event.save_event

    @link = calendar.event_href @title

  end

end