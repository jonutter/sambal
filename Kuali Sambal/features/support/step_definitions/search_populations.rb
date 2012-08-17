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

Then /^the search results should include a population where "description" includes "60-89 credit hours"$/ do

end

When /^I search populations for state is "Active"$/ do

end

When /^I search populations for keyword is "Athletic Managers & Trainers" and state "Inactive"$/ do

end

Then /^the search results should include a population with "Name" "Athletic Managers & Trainers" and "State" "Inactive"$/ do

end

When /^I search populations for keyword is "Athlete"$/ do

end

And /^select population with name "Athlete" from the search results$/ do

end
Then a read-only view of the population is displayed
And the view of the population "name" field is "Athlete"
And the view of the population "description" field is "Students who are members of an NCAA certified sport"
And the view of the population "type" field is "rule"
And the view of the population "state" field is "active"