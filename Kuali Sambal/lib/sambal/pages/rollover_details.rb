class RolloverDetails

  wrapper_elements
  frame_element
  
  crucial_element(:term) { |b| b.frame_el.text_field(name: "rolloverTargetTermCode") }
  
  action(:go) { |b| b.frame_el.button(text: "Go").click; loading.wait_while_present }
  
end