class EventObject

  include PageHelper
  include Utilities
  include Workflows

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
        :message=>random_multiline(400,20, :alpha),
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
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    calendar unless @browser.title=~/Calendar$/
    on Calendar do |cal|
      cal.add
    end
    on AddEditEvent do |add_event|
      add_event.message.set @message
      add_event.title.set @title
      add_event.month.select @month
      add_event.day.select @day
      add_event.year.select @year
      add_event.start_hour.select @start_hour
      add_event.start_minute.select @start_minute
      add_event.start_meridian.select @start_meridian
      if @end_hour == nil && @duration_hours == nil
        @duration_hours = add_event.hours.value
        @duration_minutes = add_event.minutes.value
        @end_hour = add_event.end_hour.value
        @end_minute = add_event.end_minute.value
        @end_meridian = add_event.end_meridian.value
      elsif @end_hour == nil
        add_event.hours.select @duration_hours
        add_event.minutes.select @duration_minutes
        @end_hour = add_event.end_hour.value
        @end_minute = add_event.end_minute.value
        @end_meridian = add_event.end_meridian.value
      elsif @duration_hours == nil

      else

      end

      add_event.save_event
    end
    on Calendar do |cal|
      @link = cal.event_href @title
    end
  end

end