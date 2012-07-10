class CreateNewAcadCalendar < BasePage

  wrapper_elements
  frame_element

  element(:start_blank_calendar) { |b| b.frame_el.link(text: "Start a blank calendar instead?") }
  element(:choose_different_calendar) { |b| b.frame_el.link(text: "Choose a Different Calendar") }
  element(:name) { |b| b.frame_el.text_field(name: "academicCalendarInfo.name") }
  element(:start_date) { |b| b.frame_el.text_field(name: "academicCalendarInfo.startDate") }
  element(:end_date) { |b| b.frame_el.text_field(name: "academicCalendarInfo.endDate") }

  action(:copy_calendar) { |b| b.frame_el.button(text: /Copy Academic Calendar/) }

end