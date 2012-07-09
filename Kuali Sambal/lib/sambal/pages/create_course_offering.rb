class CreateCourseOffering < BasePage

  header_elements
  footer_elements
  common_elements
  frame_element

  crucial_element(:target_term) { |b| b.frame_el.text_field(id: "u115_control") }
  crucial_element(:catalogue_course_code) { |b| b.frame_el.text_field(id: "u133_control") }

  action(:show) { |b| b.frame_el.button(id: "u150").click; loading.wait_while_present }
  action(:create_offering) { |b| b.frame_el.button(id: "createOfferingButton").click; loading.wait_while_present }
  action(:search) { |b| b.frame_el.link(text: "Search").click; loading.wait_while_present }

end