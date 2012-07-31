class ActivePopulationLookup < BasePage

  wrapper_elements
  frame_element

  element(:keyword) { |b| b.text_field(name: "criteriaFields[keyword]") }
  
  action(:search) { |b| b.button(id: "u57").click; b.loading.wait_while_present }
  action(:clear_values) { |b| b.button(id: "u58").click; b.loading.wait_while_present }
  action(:close) { |b| b.button(id: "u62").click; b.loading.wait_while_present }

end