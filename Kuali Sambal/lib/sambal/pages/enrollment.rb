class Enrollment < BasePage

  wrapper_elements
  frame_element

  action(:home) { |p| p.frame_el.link(text: "Home").click }
  action(:search_for_calendar_or_term) { |p| p.frame_el.link(text: "Search for Calendar or Term").click }
  action(:create_new_calendar) { |p| p.frame_el.link(text: "Create New Calendar (Academic Year)").click }
  action(:create_holiday_calendar) { |p| p.frame_el.link(text: "Create Holiday Calendar").click }
  action(:perform_rollover) { |p| p.frame_el.link(text: "Perform Rollover").click }
  action(:view_rollover_details) { |p| p.frame_el.link(text: "View Rollover Details").click }
  action(:create_course_offerings) { |p| p.frame_el.link(text: "Create Course Offerings").click }
  action(:manage_course_offerings) { |p| p.frame_el.link(text: "Manage Course Offerings").click }
  action(:manage_registration_windows) { |p| p.frame_el.link(text: "Manage Registration Windows and Appointments").click }

end