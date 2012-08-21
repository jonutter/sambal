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
      :child_populations=>[],
      :rule=>nil,
      :reference_population=>nil,
      :state=>"Active"
    }
    options = defaults.merge(opts)

    @name=options[:name]
    @description=options[:description]
    @type = options[:type]
    @child_populations = options[:child_populations]
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
      page.by_using_populations unless @type == 'rule-based'
      case(@type)
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
          @reference_population == nil ? add_random_ref_pop : add_ref_pop
        else
          puts "Your population type value must be one of the following:\n'rule-based', 'union-based', 'intersection-based', or 'exclusion-based'.\nPlease update your script"
          exit
      end
      unless type=='rule-based'
        if @child_populations == []
          2.times{add_random_population}
        else
          @child_populations.each do |pop|
            add_child_population(pop)
          end
        end
      end
    end
    on CreatePopulation do |page|
      # Click the create population button...
      page.create_population
    end
  end

  def edit_population(opts={})

    defaults = {
      :name=>@name,
      :description=>@description,
      :status=>@status,
      :rule=>@rule,
      :ref_pop=>@reference_population,
      :child_pops=>@child_populations
    }
    options=defaults.merge(opts)

    go_to_manage_population
    on ManagePopulations do |page|
      page.keyword.set @name
      page.both.set
      page.search
      page.edit @name
    end
    on EditPopulation do |page|
      page.name.set options[:name]
      page.description.set options[:description]
      page.send(options[:status].downcase).set
      page.rule.set(options[:rule]) unless options[:rule] == nil
      update_ref_pop(options[:ref_pop]) unless options[:ref_pop] == @reference_population
      unless @child_populations == options[:child_pops]
        page.child_populations.each { |pop| page.remove_population(pop) }
        options[:child_pops].each { |pop| add_child_population(pop) }
      end
      page.update
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
      page.wait_until(15) { page.population.value == child_population }
      page.add
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
    @child_populations << population
  end

  def add_ref_pop
    on CreatePopulation do |page|
      page.lookup_ref_population
    end
    on ActivePopulationLookup do |page|
      page.keyword.wait_until_present
      page.keyword.set @reference_population
      page.search
      page.return_value @reference_population
    end
    on CreatePopulation do |page|
      page.wait_until(10) { page.reference_population.value == @reference_population }
    end
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
    @reference_population = population
  end

  def update_ref_pop(pop)
    on EditPopulation do |page|
      page.lookup_ref_pop
    end
    on ActivePopulationLookup do |page|
      page.keyword.wait_until_present
      page.keyword.set pop
      page.search
      page.return_value pop
    end
    on CreatePopulation do |page|
      page.wait_until(10) { page.reference_population.value == pop }
    end
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