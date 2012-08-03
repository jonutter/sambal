class CreatePopulation < PopulationsBase

  frame_element
  population_attribute_elements
  include PopulationEdit

  action(:by_using_populations) { |b| b.frm.link(text: "By Using Populations").click; b.loading.wait_while_present }
  action(:by_rule) { |b| b.frm.link(text: "By Rule").click; b.loading.wait_while_present }
  action(:union) { |b| b.frm.radio(value: "kuali.population.rule.type.union").set }
  action(:intersection) { |b| b.frm.radio(value: "kuali.population.rule.type.intersection").set }
  action(:exclusion) { |b| b.frm.radio(value: "kuali.population.rule.type.exclusion").set }
  action(:create_population) { |b| b.frm.button(id: "u487").click; b.loading.wait_while_present }

end