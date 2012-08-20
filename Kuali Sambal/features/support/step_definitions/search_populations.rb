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

When /^I search populations with Keyword "(.*)" and State "(.*)"$/ do |keywerd, state|
  methd = state.downcase
  on ManagePopulations do |page|
    page.keyword.set keywerd
    page.send(methd)
    page.search
  end
end

Then /^the search results should include a population with Name "(.*)" and State "(.*)"$/ do |name, state|
  on ManagePopulations do |page|
    page.results_list.should include name
    page.status(name).should == state
  end
end

When /^I search populations with keyword "(.*)"$/ do |keywerd|
  on ManagePopulations do |page|
    page.keyword.set keywerd
    page.search
  end
end

And /^I view the population with name "(.*)" from the search results$/ do |name|
  on ManagePopulations do  |page|
    page.view name
  end
end

And /^the view of the population "(.*)" field is "(.*)"$/ do |field, value|
  methd = {}
  on ViewPopulation do |page|
    page.send(methd).should == value
  end
end