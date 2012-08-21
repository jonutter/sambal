When /^I edit the (.*) of the population$/ do |attrib|

  @population.edit_population()
end

Then /^a read-only view of the population is displayed$/ do
  on ViewPopulation do |page|
    page.header.should == "View Population"
  end
end

When /^I rename a population with an existing name$/ do


end

Then /^the population name is not changed$/ do

end