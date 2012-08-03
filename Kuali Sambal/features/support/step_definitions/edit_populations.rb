When /^I edit the (.*) of the population$/ do |attrib|
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.search
    page.edit @pop_name
  end
  on EditPopulation do |page|
    case(attrib)
      when 'name'
        @new_name = random_alphanums
        page.name.set @new_name
      when 'description'
        @new_description = random_alphanums
        page.description.set @new_description
      when 'state'
        if page.active.set?
          page.inactive.set
        else
          page.active.set
        end
      when 'rule'
        # Select a random rule...
        def new_random_rule
          new_rule = random_rule
          if new_rule == @rule
            new_random_rule
          else
            new_rule
          end
        end
        @new_rule = new_random_rule
        page.rule.select @new_rule
      when 'populations'
        page.remove_population @pop1
        page.remove_population @pop2
        @new_pop1 = add_random_population
        @new_pop2 = add_random_population
    end
    page.update
  end
end

Then /^a read-only view of the population information is displayed$/ do
  on ViewPopulation do |page|
    page.name.should == @new_name
    page.description.should == @new_description
    page.populations.should include @new_pop1
    page.populations.should include @new_pop2
  end
end