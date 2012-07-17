class CopyAcademicCalendar < BasePage

  wrapper_elements
  frame_element

  element(:copy_to_name) { |b| b.frm.text_field(name: "academicCalendarInfo.name") }
  element(:copy_to_start_date) { |b| b.frm.text_field(name: "academicCalendarInfo.startDate") }
  element(:copy_to_end_date) { |b| b.frm.text_field(name: "academicCalendarInfo.endDate") }

  action(:copy_academic_calendar) { |b| b.frm.button(id: "u53").click; loading.wait_while_present }

end