class ActivePopulationLookup < PopulationsBase

  expected_element :keyword

  def frm
    self.frame(class: "fancybox-iframe")
  end

  include PopulationsSearch

  population_lookup_elements
  green_search_buttons

end