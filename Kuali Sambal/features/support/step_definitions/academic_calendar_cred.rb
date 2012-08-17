Given /^I am logged in as admin$/ do
  visit Login do |page|
    page.login_with "admin", "admin"
  end
end

When /^I create an Academic Calendar$/ do
  @calendar_name = random_alphanums
  @start_date = "09/01/#{next_year}"
  @end_date = "06/20/#{next_year + 1}"
  visit MainMenu do |page|
    page.enrollment_home
  end
  on Enrollment do |page|
    page.create_academic_calendar
  end
  on CreateAcadCalendar do |page|
    page.name.set @calendar_name
    page.start_date.set @start_date
    page.end_date.set @end_date
    page.copy_academic_calendar
  end
end

When /^I save the (Academic Calendar|Holiday Calendar|Academic Term)$/ do |arg|
  klass = case(arg)
            when "Academic Calendar"
              AcademicCalendar
            when "Holiday Calendar"
              CreateHolidayCalendar
          end
  on klass do |page|
    page.save
  end
end

Then /^I should be able to save the (Academic Calendar|Holiday Calendar), and the Make Official button should become active$/ do |arg|
  klass = case(arg)
            when "Academic Calendar"
              AcademicCalendar
            when "Holiday Calendar"
              CreateHolidayCalendar
          end
  on klass do |page|
    page.make_official_button.should be_disabled
    page.save
    page.make_official_button.should be_enabled
  end
end

When /^I search for the (Holiday Calendar|Academic Calendar|Academic Term)$/ do |arg|
  visit MainMenu do |page|
    page.enrollment_home
  end
  on Enrollment do |page|
    page.search_for_calendar_or_term
  end
  on CalendarSearch do |page|
    page.search_for arg, @calendar_name
  end
end

Then /^the calendar (.*) appear in search results$/ do |arg|
  on CalendarSearch do |page|
    if arg == "should"
      page.results_list.should include @calendar_name
    else
      page.results_list.should_not include @calendar_name
    end
  end
end

When /^I make the (.*) official$/ do |arg|
  klass = case(arg)
            when "Academic Calendar"
              AcademicCalendar
            when "Holiday Calendar"
              CreateHolidayCalendar
          end
  on klass do |page|
    page.make_official
  end
end

Then /^the calendar (.*) be set to Official$/ do |arg|
  on CalendarSearch do |page|
    if arg == "should"
      page.calendar_status(@calendar_name).should == "Official"
    else
      page.calendar_status(@calendar_name).should_not == "Official"
    end
  end
end

When /^I copy the Academic Calendar$/ do
  on CalendarSearch do |page|
    page.copy @calendar_name
  end
  on CreateAcadCalendar do |page|
    page.name.set random_alphanums
    page.start_date.set "01/02/#{next_year}"
    page.end_date.set "12/31/#{next_year}"
  end
end

When /^I update the Academic Calendar$/ do
  @new_name = random_alphanums
  @new_start_date = "02/15/#{next_year}"
  @new_end_date = "07/06/#{next_year}"
  visit MainMenu do |page|
    page.enrollment_home
  end
  on Enrollment do |page|
    page.search_for_calendar_or_term
  end
  on CalendarSearch do |page|
    page.search_for_academic_calendar @calendar_name
    page.edit @calendar_name
  end
  on AcademicCalendar do |page|
    page.name.set @new_name
    page.start_date.set @new_start_date
    page.end_date.set @new_end_date
    page.save
  end
end

When /^I delete the Academic Calendar draft$/ do
  on AcademicCalendar do |page|
    page.delete_draft

    sleep 5
    page.alert.ok
  end
end

Then /^the calendar should reflect the updates$/ do

end

When /^I search for the Academic Calendar with wildcards$/ do
  pending
end

When /^I search for the Academic Calendar using partial name$/ do
  pending
end