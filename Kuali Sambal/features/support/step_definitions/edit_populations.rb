When /^I edit the (.*) of the population$/ do |attrib|
  go_to_manage_population
  on ManagePopulations do |page|
    page.keyword.set @pop_name
    page.both.set
    page.search
    page.edit @pop_name
  end
  on EditPopulation do |page|
    case(attrib)
      when 'name'
        @old_name = @pop_name
        @pop_name = random_alphanums
        page.name.set @pop_name
      when 'description'
        @old_description = @pop_desc
        @pop_desc = random_alphanums
        page.description.set @pop_desc
      when 'state'
        if page.active.set?
          page.inactive.set
        else
          page.active.set
        end
      when 'rule'
        @old_rule = @rule
        # Select a random rule...
        def new_random_rule
          new_rule = page.random_rule
          if new_rule == @old_rule
            new_random_rule
          else
            new_rule
          end
        end
        @rule = new_random_rule
        page.rule.select @rule
      when 'populations'
        @old_pop1 = @pop1
        @old_pop2 = @pop2
        page.remove_population @pop1
        page.remove_population @pop2
        @pop1 = add_random_population
        @pop2 = add_random_population
    end
    page.update
  end
end

Then /^a read-only view of the population information is displayed$/ do
  on ViewPopulation do |page|
    page.name.should == @pop_name
    page.description.should == @pop_desc
    page.populations.should include @pop1
    page.populations.should include @pop2
  end
end