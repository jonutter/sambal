class ActivePopulationLookup < PopulationsBase

  def frm
    self.frame(id: "fancybox-frame")
  end

  include PopulationsSearch

  population_lookup_elements
  green_search_buttons

end