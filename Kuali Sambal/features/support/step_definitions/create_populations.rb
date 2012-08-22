When /^I create a population that is (.*)$/ do |type|
  @population = make Population, :type=>type
  @population.create_population
end

When /^I create another population with the same name$/ do
  @population2 = make Population, :name=>@population.name
  @population2.create_population
end

Then /^an error message appears indicating that the Population Name is NOT unique$/ do
  on CreatePopulation do |page|
    page.first_error.should == "Name: Population Name #{@population.name} is already in use. Please enter a different, unique population name."
  end
end

Then /^there is no new population created$/ do
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @population.name
    page.search
    page.results_list.length.should == 2 #imperfect since keyword search also searches description
  end
end

Then /^the population exists with a state of "(.*?)"$/ do |state|
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @population
    page.search
    page.status(@population).should == state
  end
end

Then /^an error message appears stating "(.*?)"$/ do |errMsg|
  on CreatePopulation do |page|
    page.first_error.should match /.*#{errMsg}.*/
  end
end

When /^I try to create a population that is exclusion-based with no reference population$/ do
  @population = make Population, :type=>"exclusion-based", :reference_population=>" "
  @population.create_population
end

When /^I try to create a population that is union-based with one population$/ do
  @population = make Population, :type=>"union-based", :child_populations=>%w{random}
  @population.create_population
end


When /^I create an union-based population with 3 populations$/ do
  @population = make Population, :type=>"union-based", :child_populations=>%w{random random random}
  @population.create_population
end

When /^I create an exclusion-based population with 2 additional populations$/ do
  @population = make Population, :type=>"exclusion-based", :child_populations=>%w{random random random}
  @population.create_population
end
