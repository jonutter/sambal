class HolidayCalendar

  include PageHelper
  include Workflows
  include Utilities

  attr_accessor :name, :start_date, :end_date, :organization, :holiday_types

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :name=>random_alphanums,
      :start_date=>"09/01/#{next_year}",
      :end_date=>"06/25/#{next_year + 1}",
      :organization=>"Registrar's Office",
      :holiday_types=>[
      {:type=>"random", :start_date=>"02/01/#{next_year + 1}", :all_day=>true, :date_range=>false, :instructional=>false},
      {:type=>"random", :start_date=>"03/02/#{next_year + 1}", :end_date=>"03/04/#{next_year + 1}", :all_day=>true, :date_range=>true, :instructional=>false},
      {:type=>"random", :start_date=>"04/05/#{next_year + 1}", :start_time=>"03:00", :start_meridian=>"pm", :end_time=>"07:44", :end_meridian=>"pm", :all_day=>false, :date_range=>false, :instructional=>false},
      {:type=>"random", :start_date=>"05/11/#{next_year + 1}", :start_time=>"02:22", :start_meridian=>"am", :end_date=>"05/22/#{next_year + 1}", :end_time=>"07:44", :end_meridian=>"pm", :all_day=>false, :date_range=>true, :instructional=>false}
      ]
    }
    options = defaults.merge(opts)

    @name=options[:name]
    @start_date=options[:start_date]
    @end_date=options[:end_date]
    @organization=options[:organization]
    @holiday_types=options[:holiday_types]

  end

  def create
    visit MainMenu do |page|
      page.enrollment_home
    end
    on Enrollment do |page|
      page.create_holiday_calendar
    end
    on CopyHolidayCalendar do |page|
      page.start_blank_calendar
    end
    on CreateHolidayCalendar do |page|
      page.name.set @name
      page.start_date.set @start_date
      page.end_date.set @end_date
      page.organization.select @organization
      @holiday_types.each do |holiday|
        if holiday[:type] == "random"
          page.select_random_holiday
          holiday[:type]=page.holiday_type.value
          puts holiday[:type] # TODO: Remove this DEBUG Line after test
        else
          page.holiday_type.select holiday[:type]
        end
        page.holiday_start_date.set holiday[:start_date]
        if holiday[:date_range]
          page.date_range.set
          begin
            wait_until { holiday_end_date.enabled? }
          rescue Selenium::WebDriver::Error::StaleElementReferenceError
            sleep 2
          end
          page.holiday_end_date.set holiday[:end_date]
        else
          page.date_range.clear if page.date_range.set?
        end
        if holiday[:all_day]
          all_day.set unless all_day.set?
        else
          page.start_time
        end
      end
    end
  end

end