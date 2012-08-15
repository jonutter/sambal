class CreateAcadCalendar < BasePage

  expected_element :name

  wrapper_elements
  frame_element

  value(:source_name) { |b| b.frm.div(id: "u110").text } # Persistent ID needed!
  value(:source_start_date) { |b| b.frm.span(id: "u121").text } # Persistent ID needed!
  value(:source_end_date) { |b| b.frm.span(id: "u132").text } # Persistent ID needed!
  
  element(:start_blank_calendar) { |b| b.frm.link(text: "Start a blank calendar instead?") }
  element(:choose_different_calendar) { |b| b.frm.link(text: "Choose a Different Calendar") }
  element(:name) { |b| b.frm.text_field(name: "academicCalendarInfo.name") }
  element(:start_date) { |b| b.frm.text_field(name: "academicCalendarInfo.startDate") }
  element(:end_date) { |b| b.frm.text_field(name: "academicCalendarInfo.endDate") }

  action(:copy_academic_calendar) { |b| b.frm.button(text: /Copy Academic Calendar/).click; b.loading.wait_while_present }

end