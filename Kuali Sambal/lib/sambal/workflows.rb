# This module contains methods that exist in a grey, nebulous middle zone...
# They aren't quite step definitions, but they involve multiple
# page classes.
module Workflows

  # Site Navigation helpers...
  def go_to_create_population
    visit MainMenu do |page|
      page.population_maintenance_edoc
    end
  end

  def go_to_manage_population
    visit MainMenu do |page|
      page.manage_population
    end
  end

  def go_to_manage_course_offerings
    visit MainMenu do |page|
      page.manage_course_offerings
    end
  end

  # Larger flows...

  def add_random_population
    on CreatePopulation do |page|
      page.lookup_population
    end
    population = search_for_pop
    on ActivePopulationLookup do |page|
      page.return_value population
    end
    on CreatePopulation do |page|
      page.wait_until(15) { page.population.value == population }
      page.add
    end
    population
  end

  def add_random_ref_pop
    on CreatePopulation do |page|
      page.lookup_ref_population
    end
    population = search_for_pop
    on ActivePopulationLookup do |page|
      page.return_value @names[0]
    end
    on CreatePopulation do |page|
      page.wait_until(10) { page.reference_population.value == population }
    end
    population
  end

  private

  def search_for_pop
    on ActivePopulationLookup do |page|
      page.keyword.wait_until_present
      page.keyword.set random_letters(1)
      page.search
      @names = page.results_list
    end
    search_for_pop if @names.length < 2
    @names.shuffle!
    if @names[0] != @pop1
      @names[0]
    else
      @names[1]
    end
  end

end