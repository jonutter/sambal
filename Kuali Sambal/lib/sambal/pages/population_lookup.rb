class PopulationLookup < BasePage
  
  wrapper_elements
  frame_element
  green_search_buttons
  
  element(:keyword) { |b| b.frm.text_field(name: "criteriaFields[keyword]") }

  action(:create_new) { |b| b.frm.link(text: "Create New").click }
  
end