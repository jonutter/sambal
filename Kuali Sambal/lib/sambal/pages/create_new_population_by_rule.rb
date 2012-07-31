class CreatePopulation < BasePage

  wrapper_elements
  frame_element

  action(:by_using_populations) { |b| b.frm.link(text: "By Using Populations").click; b.loading.wait_while_present }
  action(:by_rule) { |b| b.frm.link(text: "By Rule").click; b.loading.wait_while_present }

  element(:name) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.name") }
  element(:description) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.descr") }
  element(:rule) { |b| b.select(name: "document.newMaintainableObject.dataObject.populationRuleInfo.agendaIds[0]") }
  element(:population) { |b| b.text_field(name: "document.newMaintainableObject.dataObject.operationType") }

  action(:union) { |b| b.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:intersection) { |b| b.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:exclusion) { |b| b.radio(name: "document.newMaintainableObject.dataObject.operationType").set }
  action(:lookup_population) { |b| b.button(title: "Search Field").click; b.loading.wait_while_present }
  action(:create_population) { |b| b.button(id: "u487").click; b.loading.wait_while_present }

end