class CreatePopulation < PopulationsBase

  expected_element :name

  frame_element
  population_attribute_elements
  validation_elements
  include PopulationEdit

  element(:union_radio) { |b| b.frm.radio(value: "kuali.population.rule.type.union") }

  action(:by_using_populations) { |b| b.frm.link(text: "By Using Populations").click; b.loading.wait_while_present } # Persistent ID needed!
  action(:by_rule) { |b| b.frm.link(text: "By Rule").click; b.loading.wait_while_present } # Persistent ID needed!
  action(:union) { |b| b.union_radio.set }
  action(:intersection) { |b| b.frm.radio(value: "kuali.population.rule.type.intersection").set }
  action(:exclusion) { |b| b.frm.radio(value: "kuali.population.rule.type.exclusion").set }
  action(:create_population) { |b| b.frm.button(text: "Create Population").click; b.loading.wait_while_present } # Persistent ID needed!

end