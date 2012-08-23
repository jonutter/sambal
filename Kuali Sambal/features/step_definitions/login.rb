Given /^I am logged in as admin$/ do
  log_in "admin", "admin" unless logged_in_user == "admin"
end