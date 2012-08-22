When /^I create a population that is (.*)$/ do |type|
  @population = Population.new @browser
  @population.create_population
end

When /^I create another population with the same name$/ do
  @population2 = Population.new(@browser, :name=>@population.name)
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
    page.keyword.set @pop_name
    page.search
    page.results_list.length.should == 2 #imperfect since keyword search also searches description
  end
end

Then /^the population exists with a state of "(.*?)"$/ do |state|
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.search
    page.status(@pop_name).should == state
  end
end

Then /^an error message appears stating "(.*?)"$/ do |errMsg|
	on CreatePopulation do |page|
		page.first_error.should match /.*#{errMsg}.*/
	end
end

When /^I try to create a population that is exclusion-based with no reference population$/ do
  # navigate to page...
  go_to_create_population
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
	  page.name.set @pop_name
	  page.description.set @pop_desc
	  page.by_using_populations
	  page.exclusion
	  @pop1 = add_random_population
	  page.create_population
  end

end

When /^I try to create a population that is union-based with one population$/ do
  # navigate to page...
  go_to_create_population
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
	  page.name.set @pop_name
	  page.description.set @pop_desc
	  page.by_using_populations
	  page.union
	  @pop1 = add_random_population
	  page.create_population
  end

end


When /^I create an union-based population with 3 populations$/ do
  # navigate to page...
  go_to_create_population
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
	  page.name.set @pop_name
	  page.description.set @pop_desc
	  page.by_using_populations
	  page.union
	  @pop1 = add_random_population
	  @pop2 = add_random_population
	  @pop3 = add_random_population
	  page.create_population
    end

end

When /^I create an exclusion-based population with 2 additional populations$/ do
  # navigate to page...
  go_to_create_population
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
	  page.name.set @pop_name
	  page.description.set @pop_desc
	  page.by_using_populations
	  page.exclusion
	  @ref_pop = add_random_ref_pop
	  @pop1 = add_random_population
	  @pop2 = add_random_population
	  page.create_population
  end

end
