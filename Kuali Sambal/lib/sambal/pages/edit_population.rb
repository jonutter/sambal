class EditPopulation < PopulationsBase

  frame_element
  population_attribute_elements
  include PopulationEdit

  element(:active) { |b| b.frm.radio(value: "kuali.population.population.state.active") }
  element(:inactive) { |b| b.frm.radio(value: "kuali.population.population.state.inactive") }

  action(:update) { |b| b.frm.button(text: "Update").click; b.loading.wait_while_present } # Persistent ID needed!

end