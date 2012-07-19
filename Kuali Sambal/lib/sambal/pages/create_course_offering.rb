class CreateCourseOffering < BasePage

  wrapper_elements
  frame_element
  doc_info_elements

  crucial_element(:target_term) { |b| b.frm.text_field(id: "u115_control") }
  crucial_element(:catalogue_course_code) { |b| b.frm.text_field(id: "u133_control") }

  action(:show) { |b| b.frm.button(id: "u150").click; b.loading.wait_while_present }
  action(:create_offering) { |b| b.frm.button(id: "createOfferingButton").click; b.loading.wait_while_present }
  action(:search) { |b| b.frm.link(text: "Search").click; b.loading.wait_while_present }

end