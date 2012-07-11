class DeleteTargetTerm < BasePage

  wrapper_elements
  frame_element

  element(:term) { |b| b.frm.text_field(name: "targetTermCode") }

  action(:go) { |b| b.frm.button(text: "Go").click; loading.wait_while_present }
  action(:delete_target_term) { |b| b.frm.button(text: "Delete Target Term").click; loading.wait_while_present }

end