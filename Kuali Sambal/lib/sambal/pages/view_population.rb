class ViewPopulation < BasePage
  
  wrapper_elements
  frame_element
  
  value(:name) { |b| b.frm.span(id: "u172").text }
  value(:description) { |b| b.frm.span(id: "u190").text }
  value(:state) { |b| b.frm.span(id: "u208").text }
  value(:operation) { |b| b.frm.span(id: "u226").text }

  # Returns an array containing strings for all the populations listed on the page
  def populations
    list = []
    self.divs(id: /_line/).each { |name| list << name.text }
    list
  end
  
end