# This module contains methods that exist in a grey, nebulous middle zone...
# They aren't quite step definitions, but they involve multiple
# page classes.
module Workflows

  def add_random_population
    on CreatePopulation do |page|
      page.lookup_population
    end
    on ActivePopulationLookup do |page|
      page.keyword.wait_until_present
      page.keyword.set random_letters(1)
      page.search
      @names = page.results_list
    end
    if @names.length == 0
      add_random_population
    else
      @names.shuffle!
      on ActivePopulationLookup do |page|
        page.return_value @names[0]
      end
      on CreatePopulation do |page|
        page.population.value.should == @names[0]
        page.add
      end
    end
  end

end