class ManageRegistrationWindows < BasePage

  wrapper_elements
  frame_element
  validation_elements

  element(:term_type) { |b| b.frm.select(name: "termType") }
  element(:year) { |b| b.frm.text_field(name: "termYear") }

  action(:search) { |b| b.frm.button(text: "Search").click; b.loading.wait_while_present } # Persistent ID needed!

end