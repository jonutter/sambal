Given /^I am logged in as admin$/ do
  visit Login do |page|
    page.login_with "admin", "admin"
  end
end

When /^I create a new Academic Calendar$/ do
  visit MainMenu do |page|
    page.create_academic_calendar
  end
  on NewAcademicCalendar do |page|
    page.academic_calendar_name.set "Test Name"
    page.calendar_start_date.set "01/01/2013"
    page.calendar_end_date.set "12/31/2013"
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
    page.calendar_search
  end
  on CalendarSearch do |page|
    page.search_for_academic_calendar "Test Name", "2013"
    page.search_results.row(text: "Test Name").should exist
  end
end

Then /^it should appear in search results$/ do
  pending # express the regexp above with the code you wish you had
end


