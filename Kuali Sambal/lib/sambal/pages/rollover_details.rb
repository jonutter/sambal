class RolloverDetails < BasePage

  wrapper_elements
  frame_element
  
  crucial_element(:term) { |b| b.frm.text_field(name: "rolloverTargetTermCode") }
  
  action(:go) { |b| b.frm.button(text: "Go").click; loading.wait_while_present }
  
end