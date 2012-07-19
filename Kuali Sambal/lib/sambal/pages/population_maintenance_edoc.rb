class PopulationMaintenanceEDoc < BasePage

  wrapper_elements
  frame_element
  doc_info_elements

  action(:expand_all) { |b| b.frm.button(id: "u201").click }
  action(:collapse_all) { |b| b.frm.button(id: "u202").click }
  
  element(:name) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.name") }
  element(:description) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.descr") }
  
  action(:submit) { |b| b.frm.button(id: "u212").click }

end