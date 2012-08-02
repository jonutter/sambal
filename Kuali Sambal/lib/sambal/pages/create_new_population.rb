class CreatePopulation < BasePage

  wrapper_elements
  frame_element

  action(:by_using_populations) { |b| b.frm.link(text: "By Using Populations").click; b.loading.wait_while_present }
  action(:by_rule) { |b| b.frm.link(text: "By Rule").click; b.loading.wait_while_present }

  element(:name) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.name") }
  element(:description) { |b| b.frm.text_field(id: /(u95_control|u190_control)/) }
  element(:rule) { |b| b.frm.select(name: "document.newMaintainableObject.dataObject.populationRuleInfo.agendaIds[0]") }
  element(:population) { |b| b.frm.text_field(id: "u441_add_control") }

  action(:union) { |b| b.frm.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:intersection) { |b| b.frm.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:exclusion) { |b| b.frm.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:lookup_population) { |b| b.frm.button(id: "u455_add").click; b.loading.wait_while_present }
  action(:add) { |b| b.frm.button(id: "u440_add").click; b.loading.wait_while_present; sleep 1.5 }
  action(:create_population) { |b| b.frm.button(id: "u487").click; b.loading.wait_while_present }

  value(:error_message) { |b| b.frm.li(class: "uif-errorMessageItem").text }

end