class CourseOfferingInfoLookup < BasePage

  expected_element :text_field, {name: "criteriaFields[termId]"}, 1

  wrapper_elements
  frame_element
  green_search_buttons

  element(:term_id) { |b| b.frm.text_field(name: "criteriaFields[termId]") }
  element(:subject_area) { |b| b.frm.text_field(name: "criteriaFields[subjectArea]") }

end