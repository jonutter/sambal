class UnknownTermCourseOfferings < BasePage

  wrapper_elements
  frame_element

  element(:i_understand) { |b| b.frame_el.checkbox(name: "acceptIndicator") }

  action(:release_to_departments) { |b| b.frame_el.button(id: "u109").click; loading.wait_while_present }

end