Given /^I am logged in as admin$/ do
  visit Login do |page|
    page.login_with "admin", "admin"
  end
end

When /^I create a new Academic Calendar$/ do
  @calendar_name = random_alphanums
  visit MainMenu do |page|
    page.enrollment_home
  end
  on Enrollment do |page|
    page.create_academic_calendar
  end
  on CreateNewAcadCalendar do |page|
    page.name.set @calendar_name
    page.start_date.set "01/01/2013"
    page.end_date.set "12/31/2013"
    page.copy_academic_calendar
  end
end

When /^I save the new academic calendar$/ do
  on NewAcademicCalendar do |page|
    page.save
  end
end

Then /^I should be able to save it, and the Make Official button should become active$/ do
  on NewAcademicCalendar do |page|
    page.make_official_button.should be_disabled
    page.save
    page.make_official_button.should be_enabled
  end
end

When /^I search for the Academic Calendar$/ do
  visit MainMenu do |page|
    page.enrollment_home
  end
  on Enrollment do |page|
    page.search_for_calendar_or_term
  end
  on CalendarSearch do |page|
    page.search_for_academic_calendar @calendar_name
  end
end

Then /^it should appear in search results$/ do
  on CalendarSearch do |page|
    page.search_results.row(text: /#{@calendar_name}/).should exist
  end
end

When /^I click Make Official$/ do
  on NewAcademicCalendar do |page|
    page.make_official
  end
end

Then /^my new calendar should be set to Official$/ do
  on CalendarSearch do |page|
    page.calendar_status(@calendar_name).should == "Official"
  end
end

When /^I copy the calendar$/ do
  on CalendarSearch do |page|
    page.copy @calendar_name
  end
  on CreateNewAcadCalendar do |page|
    page.name.set random_alphanums
    page.start_date.set "01/01/2013"
    page.end_date.set "12/31/2013"
  end
end
