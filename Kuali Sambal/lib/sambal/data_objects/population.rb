class Population

  include PageHelper
  include Workflows

  attr_accessor :name, :description, :type, :rule, :operation, :child_populations,
      :reference_population

  def initialize(browser, name, description, type, operation=nil, child_pop=nil, ref_pop=nil)
    @browser = browser
    @name = name
    @description = description
    @type = type
    @child_populations = []
    @child_populations << child_pop
    @rule = ""
    @operation = operation
    @reference_population = ref_pop
  end

  def create_population
    go_to_create_population
    on CreatePopulation do |page|
      page.name.set @name
      page.description.set @description
      sleep 20
    end
  end

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

  # Returns (as a string) one of the rules listed in the Rule selection list.
  def random_rule
    rules = []
    CreatePopulation.rule.options.to_a.each { |item| rules << item.text }
    rules.shuffle!
    @rule = rules[0]
  end

  def new_random_rule
    new_rule = random_rule
    if new_rule == @rule
      new_random_rule
    else
      new_rule
    end
    @rule = new_random_rule
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