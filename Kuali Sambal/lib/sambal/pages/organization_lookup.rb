class OrganizationLookup < BasePage
  
  frame_element
  wrapper_elements
  green_search_buttons
  
  element(:short_name) { |b| b.frm.text_field(name: "lookupCriteria[shortName]") }
  element(:long_name) { |b| b.frm.text_field(name: "lookupCriteria[longName]") }
  
end