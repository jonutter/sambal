When /^I create a new rule-based population$/ do |arg1, table|
  # navigate to page...
  # Enter a random name and description...
  # Select a random rule...
  # Click the create population button...
end

Then /^a population is created with a state of "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I create a new union-based population named "(.*?)":$/ do |arg1, arg2, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then /^an error message appears indicating that the Population Name is NOT unique$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^there is no new population created$/ do
  pending # express the regexp above with the code you wish you had
end