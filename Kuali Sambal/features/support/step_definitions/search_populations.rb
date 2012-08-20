When /^I search populations for keyword "(.*)"$/ do |arg|
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set arg
    page.search
  end
end

Then /^the search results should include a population where "(.*)" includes "(.*)"$/ do |arg1, arg2|
  methds = { :Name=>"results_names", :Description=>"results_descriptions"}
  on ManagePopulations do |page|
    page.send(methds[arg1.to_sym]).should include arg2
  end
end

When /^I search for "Active" populations$/ do
  go_to_manage_population
  on ManagePopulations do |page|
    page.active.set
    page.search
  end
end

Then /^the search results should only include "Active" populations$/ do
  on ManagePopulations do |page|
    page.results_states.each { |state| state.should == "Active" }
  end
end

When /^I search populations with Keyword "(.*)" and State "(.*)"$/ do |keyword, state|
  pending
end

Then /^the search results should include a population with Name "(.*)" and State "(.*)"$/ do |name, state|
  pending
end

When /^I search populations with keyword "(.*)"$/ do |keyword|
  pending
end

And /^I select population with name "(.*)" from the search results$/ do |name|
  pending
end

And /^the view of the population "name" field is "Athlete"$/ do
  pending # Are these necessary?
end

And /^the view of the population "description" field is "Students who are members of an NCAA certified sport"$/ do
  pending
end

And /^the view of the population "type" field is "rule"$/ do
  pending
end

And /^the view of the population "state" field is "active"$/ do
  pending
end