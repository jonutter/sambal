class DeleteTargetTerm < BasePage

  wrapper_elements
  frame_element

  element(:term) { |b| b.frame_el.text_field(name: "targetTermCode") }

  action(:go) { |b| b.frame_el.button(text: "Go").click; loading.wait_while_present }
  action(:delete_target_term) { |b| b.frame_el.button(text: "Delete Target Term").click; loading.wait_while_present }

end