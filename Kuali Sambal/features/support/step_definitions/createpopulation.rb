When /^I create a population that is (.*)$/ do |type|
  # navigate to page...
  visit MainMenu do |page|
    page.population_maintenance_edoc
  end
  # Enter a random name, description, and rule...
  @pop_name = random_alphanums
  @pop_desc = random_multiline(15, 3)
  on CreatePopulation do |page|
    page.name.set @pop_name
    page.description.set @pop_desc
    page.by_using_populations unless type == 'rule-based'
    case(type)
      when 'rule-based'
        # Select a random rule...
        rules = []
        page.rule.options.to_a.each { |item| rules << item.text }
        rules.shuffle!
        @rule = rules[0]
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
    end
  end
  # Add two random populations...
  2.times { add_random_population } unless type=='rule-based'

  on CreatePopulation do |page|
    # Click the create population button...
    page.create_population
  end
end

When /^I create another population with the same name$/ do
  # navigate to page...
  visit MainMenu do |page|
    page.population_maintenance_edoc
  end
  on CreatePopulation do |page|
    page.name.set @pop_name
    page.description.set random_alphanums
    page.create_population
  end
end

Then /^an error message appears indicating that the Population Name is NOT unique$/ do
  on CreatePopulation do |page|
    page.error_message.should == "Name: Population Name set is already in use. Please enter a different, unique population name."
  end
end

Then /^there is no new population created$/ do
  visit MainMenu do |page|
    page.manage_population
  end
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.search
    page.results_list.length.should == 1
  end
end

Then /^the population exists with a state of "(.*?)"$/ do |state|
  visit MainMenu do |page|
    page.manage_population
  end
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.search
    page.status(@pop_name).should == state
  end
end