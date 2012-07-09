class ManageCourseOfferings < BasePage

  header_elements
  footer_elements
  common_elements
  frame_element

  element(:term) { |b| b.frame_el.text_field(name: "termCode") }
  element(:course_offering_code) { |b| b.frame_el.radio(value: "courseOfferingCode") }
  element(:subject_code) { |b| b.frame_el.radio(value: "subjectCode") }
  element(:input_code) { |b| b.frame_el.text_field(name: "inputCode") }

  action(:show) { |b| b.frame_el.button(text: "Show").click; loading.wait_while_present }

end