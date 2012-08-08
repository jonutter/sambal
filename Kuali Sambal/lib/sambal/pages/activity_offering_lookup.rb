class ActivityOfferingLookup < BasePage

  wrapper_elements
  frame_element
  green_search_buttons

  element(:id) { |b| b.frm.text_field(name: "criteriaFields[id]") }

end