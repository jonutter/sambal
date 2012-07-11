class Enrollment < BasePage

  wrapper_elements
  frame_element

  action(:home) { |p| p.frm.link(text: "Home").click }
  action(:search_for_calendar_or_term) { |p| p.frm.link(text: "Search for Calendar or Term").click }
  action(:create_new_calendar) { |p| p.frm.link(text: "Create New Calendar (Academic Year)").click }
  action(:create_holiday_calendar) { |p| p.frm.link(text: "Create Holiday Calendar").click }
  action(:perform_rollover) { |p| p.frm.link(text: "Perform Rollover").click }
  action(:view_rollover_details) { |p| p.frm.link(text: "View Rollover Details").click }
  action(:create_course_offerings) { |p| p.frm.link(text: "Create Course Offerings").click }
  action(:manage_course_offerings) { |p| p.frm.link(text: "Manage Course Offerings").click }
  action(:manage_registration_windows) { |p| p.frm.link(text: "Manage Registration Windows and Appointments").click }

end