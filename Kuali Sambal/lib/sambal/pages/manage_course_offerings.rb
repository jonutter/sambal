class ManageCourseOfferings < BasePage

  wrapper_elements
  frame_element

  element(:term) { |b| b.frm.text_field(name: "termCode") }
  element(:course_offering_code) { |b| b.frm.radio(value: "courseOfferingCode") }
  element(:subject_code) { |b| b.frm.radio(value: "subjectCode") }
  element(:input_code) { |b| b.frm.text_field(name: "inputCode") }

  action(:show) { |b| b.frm.button(text: "Show").click; b.loading.wait_while_present }

end