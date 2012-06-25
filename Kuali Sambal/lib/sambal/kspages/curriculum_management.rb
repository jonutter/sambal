class KualiStudent::CurriculumManagement < KualiStudent::BasePage

  expected_title "Kuali Student Curriculum Management"

  header_elements

  # Page Elements
  element(:title_h1) { |b| b.h1(:class=>"KS-Section-Title KS-H1-Section-Title blockLayout-title") }

  value(:title) { |p| p.title_h1.text }

  action(:my_action_list) { |b| b.link(:text=>"My Action List").click }
  action(:create_a_course) { |b| b.link(:text=>"Create a Course").click }
  action(:browse_course_catalogue) { |b| b.link(:text=>"Browse Course Catalog").click }

end