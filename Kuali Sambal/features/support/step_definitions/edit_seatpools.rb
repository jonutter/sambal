When /^I create a seatpool for an activity offering by completing all fields$/ do
  on ManageCourseOfferings do |page|
    if page.codes_list.length == 0
      page.format.select "Lecture"
      page.loading.wait_while_present
      page.activity_type.select "Lecture"
      page.quantity.set "1"
      page.add
    end
    @code = page.codes_list[0]
    page.edit @code
  end
  on ActivityOfferingMaintenace do |page|
    page.total_maximum_enrollment.set "300"
    page.person_id.set "1101"
    page.select_affiliation.select "Instructor"
    page.inst_effort.set "50"
    page.add_personnel
    page.add_pool_priority.set "1"
    page.add_pool_seats.set "25"
    page.lookup_population_name
  end
  on ActivePopulationLookup do |page|
    page.keyword.set "e"
    page.search
    @pop_name = page.results_list[rand(page.results_list.length - 1)]
    page.return_value @pop_name
  end
  on ActivityOfferingMaintenace do |page|
    page.add
    page.submit
  end
end

When /^I edit the seatpool count and expiration milestone$/ do
  on ActivityOfferingMaintenace do |page|
    page.update_seats @pop_name, "20"
    page.update_expiration_milestone @pop_name, "Last Day of Registration"
  end
end

Then /^the seats remaining is updated$/ do

end

And /^the updated seatpool is saved with the activity offering$/ do

end

When /^I create 2 seatpools for an activity offering by completing all fields$/ do

end

When /^I switch the priorities for 2 seatpools$/ do

end

Then /^the updated seatpool priorities are saved with the activity offering$/ do

end

And /^I increase the overall max enrollment$/ do

end

Then /^the seatpool is saved with the activity offering$/ do

end

Given /^I am managing a course offering$/ do
  go_to_manage_course_offerings
  on ManageCourseOfferings do |page|
    page.term.set "20122"
    page.input_code.set "ENGL103"
    page.show
  end
end