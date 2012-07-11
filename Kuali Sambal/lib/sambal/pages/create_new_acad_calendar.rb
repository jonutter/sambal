class CreateNewAcadCalendar < BasePage

  wrapper_elements
  frame_element

  element(:start_blank_calendar) { |b| b.frm.link(text: "Start a blank calendar instead?") }
  element(:choose_different_calendar) { |b| b.frm.link(text: "Choose a Different Calendar") }
  element(:name) { |b| b.frm.text_field(name: "academicCalendarInfo.name") }
  element(:start_date) { |b| b.frm.text_field(name: "academicCalendarInfo.startDate") }
  element(:end_date) { |b| b.frm.text_field(name: "academicCalendarInfo.endDate") }

  action(:copy_calendar) { |b| b.frm.button(text: /Copy Academic Calendar/) }

end