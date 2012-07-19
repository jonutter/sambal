class CourseOfferingInfoLookup < BasePage

  wrapper_elements
  frame_element
  green_search_buttons

  element(:term_id) { |b| b.text_field(name: "criteriaFields[termId]") }
  element(:subject_area) { |b| b.text_field(name: "criteriaFields[subjectArea]") }

end