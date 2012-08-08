class AppointmentWindowLookup < BasePage

  expected_element :text_field, {name: "criteriaFields[termYear]"}, 1

  wrapper_elements
  frame_element
  green_search_buttons

  element(:term) { |b| b.frm.select(name: "criteriaFields[termType]") }
  element(:year) { |b| b.frm.text_field(name: "criteriaFields[termYear]") }

end