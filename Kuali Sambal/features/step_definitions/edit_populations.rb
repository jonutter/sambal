When /^I edit the (.*) of the population$/ do |attrib|
  things = {
  :name=>{:name=>random_alphanums},
  :description=>{:description=>random_multiline(20,5)},
  :rule=>{:rule=>"random"},
  :"reference population"=>{:ref_pop=>"random"},
  :"child populations"=>{:child_pops=>%w{random random}}
  }
  option = things[attrib.to_sym]
  @population.edit_population option
end

When /^I set the status of the population to "(.*)"/ do |status|
  @population.edit_population(:status=>status.downcase)
end

Then /^a read-only view of the population is displayed$/ do
  on ViewPopulation do |page|
    page.header.should == "View Population"
  end
end

When /^I rename a population with an existing name$/ do
  @population = make Population
  @population.create
  @original_name = @population.name

  @population2 = make Population
  @population2.create

  @population.edit_population :name=>@population2.name
end

Then /^the population name is not changed$/ do
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @original_name
    page.search
    page.results_list.length.should == page.results_list.uniq.length
  end
end