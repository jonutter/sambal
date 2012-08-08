class CreateCourseOffering < BasePage

  expected_element :text_field, {name: "document.newMaintainableObject.dataObject.targetTermCode"}, 1

  wrapper_elements
  frame_element

  crucial_element(:target_term) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.targetTermCode") }
  crucial_element(:catalogue_course_code) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.catalogCourseCode") }

  action(:show) { |b| b.frm.button(text: "Show").click; b.loading.wait_while_present } # Persistent ID needed!
  action(:create_offering) { |b| b.frm.button(id: "createOfferingButton").click; b.loading.wait_while_present }
  action(:search) { |b| b.frm.link(text: "Search").click; b.loading.wait_while_present } # Persistent ID needed!

end