class ManageCourseOfferings < BasePage

  wrapper_elements
  frame_element

  expected_element :term

  element(:term) { |b| b.frm.text_field(name: "termCode") }
  element(:course_offering_code) { |b| b.frm.radio(value: "courseOfferingCode") }
  element(:subject_code) { |b| b.frm.radio(value: "subjectCode") }
  element(:input_code) { |b| b.frm.text_field(name: "inputCode") }

  action(:show) { |b| b.frm.button(text: "Show").click; b.loading.wait_while_present } # Persistent ID needed!

  value(:course_title) { |b| b.frm.div(id: "KS-CourseOfferingManagement-ActivityOfferingResultSection").h3(index: 0).text }

  element(:format) { |b| b.frm.select(name: "formatIdForNewAO") }
  element(:activity_type) { |b| b.frm.select(name: "activityIdForNewAO") }
  element(:quantity) { |b| b.frm.text_field(name: "noOfActivityOfferings") }
  
  action(:add) { |b| b.frm.button(text: "Add").click; b.loading.wait_while_present } # Persistent ID needed!
  
  action(:select_all) { |b| b.frm.link(id: "KS-CourseOfferingManagement-SelectAll").click; b.loading.wait_while_present }

  AO_CODE = 1
  AO_STATUS = 2
  AO_TYPE = 3
  AO_FORMAT = 4
  AO_INSTRUCTOR = 5
  AO_MAX_ENR = 6

  element(:activity_offering_results_table) { |b| b.frm.table(class: "uif-tableCollectionLayout dataTable") } # Persistent ID needed!
  element(:selected_offering_actions) { |b| b.frm.select(name: "selectedOfferingAction") }

  action(:go) { |b| b.frm.button(text: "Go").click; b.loading.wait_while_present }

  def view_activity_offering(code)
    activity_offering_results_table.link(text: code).click
    loading.wait_while_present
  end

  def target_row(code)
    activity_offering_results_table.row(text: /#{Regexp.escape(code)}/)
  end

  def copy(code)
    target_row(code).link(text: "Copy").click
    loading.wait_while_present
  end

  def edit(code)
    target_row(code).link(text: "Edit").click
    loading.wait_while_present
  end

  def delete(code)
    target_row(code).link(text: "Delete").click
    loading.wait_while_present
  end

  def codes_list
    codes = []
    activity_offering_results_table.rows.each { |row| codes << row[AO_CODE].text }
    codes.delete_if { |code| code == "CODE" }
    codes
  end

end