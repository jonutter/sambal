class KualiStudent::CurriculumManagement < PageMaker

  expected_title "Kuali Student Curriculum Management"

  # Header elements TODO: Move these into a module or other base class
  element(:select_an_area) { |b| b.div(:id=>"gwt-debug-Application-Header-Select-an-area--label") }

  action(:logout) { |b| b.link(:text=>"Logout").click }

  # Page Elements
  value(:title) { |b| b.h1(:class=>"KS-Section-Title KS-H1-Section-Title blockLayout-title").text }

  action(:my_action_list) { |b| b.link(:text=>"My Action List").click }
  action(:create_a_course) { |b| b.link(:text=>"Create a Course").click }
  action(:browse_course_catalogue) { |b| b.link(:text=>"Browse Course Catalog").click }


end