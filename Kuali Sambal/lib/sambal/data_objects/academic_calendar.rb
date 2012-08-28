class AcademicCalendar

  include PageHelper
  include Workflows
  include Utilities

  attr_accessor :name, :start_date, :end_date, :organization

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :name=>random_alphanums,
      :start_date=>"09/01/#{next_year}",
      :end_date=>"06/25/#{next_year + 1}",
      :organization=>"Registrar's Office"
        }
    options = defaults.merge(opts)

    @name=options[:name]
    @start_date=options[:start_date]
    @end_date=options[:end_date]
    @organization=options[:organization]
  end

  def create
    visit MainMenu do |page|
      page.enrollment_home
    end
    on Enrollment do |page|
      page.create_academic_calendar
    end
    on CreateAcadCalendar do |page|
      page.start_blank_calendar
    end
    create_sub_task
  end

  def copy_from(name)
    visit MainMenu do |page|
      page.enrollment_home
    end
    on Enrollment do |page|
      page.create_academic_calendar
    end
    if right_source? name
      create_sub_task
    else
      on CreateAcadCalendar do |page|
        page.choose_different_calendar
      end
      on CalendarSearch do |page|
        page.search_for "Academic Calendar", name
        page.copy name
      end

    end

  end

  def right_source?(name)
    on CreateAcadCalendar do |page|
      if page.source_name == name
        return true
      else
        return false
      end
    end
  end

  private

  def create_sub_task
    on CreateAcadCalendar do |page|
      page.name.set @name
      page.start_date.set @start_date
      page.end_date.set @end_date
      page.copy_academic_calendar
    end
  end

end