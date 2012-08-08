When /^I create a population that is (.*)$/ do |type|
  # navigate to page...
  go_to_create_population
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
    page.name.wait_until_present(3)
    page.name.set @pop_name
    page.description.set @pop_desc
    page.by_using_populations unless type == 'rule-based'
    case(type)
      when 'rule-based'
        # Select a random rule...
        @rule = page.random_rule
        page.rule.select @rule
      when 'union-based'
        # Select union...
        page.union
      when 'intersection-based'
        # Select intersection...
        page.intersection
      when 'exclusion-based'
        # Select exclusion...
        page.exclusion
        @ref_pop = add_random_ref_pop
    end
  end
  # Add two random populations...
  unless type=='rule-based'
    @pop1 = add_random_population
    @pop2 = add_random_population unless type == 'exclusion-based'
  end

  on CreatePopulation do |page|
    # Click the create population button...
    page.create_population
  end
end

When /^I create another population with the same name$/ do
  # navigate to page...
  go_to_create_population
  on CreatePopulation do |page|
    page.name.set @pop_name
    page.description.set random_alphanums
    page.create_population
  end
end

Then /^an error message appears indicating that the Population Name is NOT unique$/ do
  on CreatePopulation do |page|
    page.first_error.should == "Name: Population Name #{@pop_name} is already in use. Please enter a different, unique population name."
  end
end

Then /^there is no new population created$/ do
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.search
    page.results_list.length.should == 1
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