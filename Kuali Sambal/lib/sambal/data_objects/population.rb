class Population

  include PageHelper
  include Workflows
  include Utilities

  attr_accessor :name, :description, :rule, :operation, :child_populations,
      :reference_population, :status, :type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :name=>random_alphanums,
      :description=>random_multiline(15,3),
      :type=>"rule-based",
      :child_populations=>nil,
      :rule=>nil,
      :reference_population=>nil,
      :state=>"Active"
    }
    options = defaults.merge(opts)

    @name=options[:name]
    @description=options[:description]
    @type = options[:type]
    @child_populations = []
    @child_populations << options[:child_populations]
    @child_populations.flatten! if @child_populations[0].class == Array
    @rule = options[:rule]
    operations = {:"union-based"=>"union",:"intersection-based"=>"intersection",:"exclusion-based"=>"exclusion"}
    @operation = operations[type.to_sym]
    @reference_population = options[:reference_population]
    @status = options[:state]
  end

  def create_population
    go_to_create_population
    on CreatePopulation do |page|
      page.name.set @name
      page.description.set @description
      page.by_using_populations unless type == 'rule-based'
      case(type)
        when 'rule-based'
          # Select a random rule if none is defined
          @rule = random_rule(page) if @rule == nil
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
          @reference_population
        else
          puts "Your population type value must be one of the following:\n'rule-based', 'union-based', 'intersection-based', or 'exclusion-based'.\nPlease update your script"
          exit
      end
      unless type=='rule-based'
        @child_populations.each do |pop|
          pop == nil ? add_random_population : add_child_population(pop)
        end
      end
    end
    on CreatePopulation do |page|
      # Click the create population button...
      page.create_population
    end
  end

  def add_child_population(child_population)
    on CreatePopulation do |page|
      page.lookup_population
    end
    on ActivePopulationLookup do |page|
      page.keyword.wait_until_present
      page.keyword.set child_population
      page.search
      page.return_value child_population
    end
    on CreatePopulation do |page|
      page.wait_until(15) { page.population.value == population }
      page.add
    end

  end

  def add_random_population
    @child_populations.compact!
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
    @child_populations << population
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
  def random_rule(page)
    rules = []
    page.rule.options.to_a.each { |item| rules << item.text }
    rules.shuffle!
    @rule = rules[0]
  end

  def new_random_rule(page)
    new_rule = random_rule(page)
    if new_rule == @rule
      new_random_rule(page)
    else
      new_rule
    end
    @rule = new_random_rule(page)
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