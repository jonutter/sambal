class ActivePopulationLookup < PopulationsBase

  expected_element :keyword

  def frm
    self.frame(class: "fancybox-iframe") # Persistent ID needed!
  end

  include PopulationsSearch

  population_lookup_elements
  green_search_buttons

end