class AcademicCalendar

  include PageHelper
  include Workflows
  include Utilities

  attr_accessor :name, :start_date, :end_date, :organization, :events,
      :holidays, :terms

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
    @events=options[:events]
    @holidays=options[:holidays]
    @terms=options[:terms]
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
    on EditAcademicCalendar do |page|
      page.academic_calendar_name.set @name
      page.organization.select @organization
      page.calendar_start_date.set @start_date
      page.calendar_end_date.set @end_date
      page.save
    end
  end

  def copy_from(name)
    visit MainMenu do |page|
      page.enrollment_home
    end
    on Enrollment do |page|
      page.create_academic_calendar
    end
    if right_source? name
      on CreateAcadCalendar do |page|
        page.name.set @name
        page.start_date.set @start_date
        page.end_date.set @end_date
      end
    else
      on CreateAcadCalendar do |page|
        page.choose_different_calendar
      end
      on CalendarSearch do |page|
        page.search_for "Academic Calendar", name
        page.copy name
      end
      on EditAcademicCalendar do |page|
        page.academic_calendar_name.set @name
        page.organization.select @organization
        page.calendar_start_date.set @start_date
        page.calendar_end_date.set @end_date
      end
    end
    on EditAcademicCalendar do |page|
      page.save
    end
  end

  def search
    visit MainMenu do |page|
      page.enrollment_home
    end
    on Enrollment do |page|
      page.search_for_calendar_or_term
    end
    on CalendarSearch do |page|
      page.search_for "Academic Calendar", @name
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

  def make_official
    on EditAcademicCalendar do |page|
      page.make_official
    end
  end

end