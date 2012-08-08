class ManagePopulations < PopulationsBase

  expected_element :text_field, {name: "lookupCriteria[keyword]"}, 1

  frame_element
  population_lookup_elements
  green_search_buttons
  include PopulationsSearch

end