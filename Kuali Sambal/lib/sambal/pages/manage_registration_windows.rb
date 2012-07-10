class ManageRegistrationWindows < BasePage

  wrapper_elements
  frame_element

  element(:term_type) { |b| b.frame_el.select(name: "termType") }
  element(:year) { |b| b.frame_el.text_field(name: "termYear") }

  action(:search) { |b| b.frame_el.button(text: "Search").click; loading.wait_while_present }

end