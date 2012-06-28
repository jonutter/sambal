class KualiStudent::CurriculumManagement < KualiStudent::BasePage

  expected_title "Kuali Student: Curriculum Management"

  header_elements
  footer_elements

  # Page Elements
  crucial_element(:title_element) { |b| b.h1(:class=>"KS-Section-Title KS-H1-Section-Title blockLayout-title") }
  crucial_element(:my_action_list_element) { |b| b.link(:text=>"My Action List") }
  crucial_element(:create_a_course_element) { |b| b.link(:text=>"Create a Course") }
  crucial_element(:browse_course_catalogue_element) { |b| b.link(:text=>"Browse Course Catalog") }
  crucial_element(:create_an_academic_program_element) { |b| b.link(:text=>"Create an Academic Program") }
  crucial_element(:find_a_course_element) { |b| b.link(:text=>"Find a Course") }
  crucial_element(:find_a_course_proposal_element) { |b| b.link(:text=>"Find a Course Proposal") }
  crucial_element(:browse_academic_programs_element) { |b| b.link(:text=>"Browse Academic Programs") }
  crucial_element(:find_academic_programs_element) { |b| b.link(:text=>"Find Academic Programs") }
  crucial_element(:find_a_program_proposal_element) { |b| b.link(:text=>"Find a Program Proposal") }
  element(:view_core_programs_element) { |b| b.link(:text=>"View Core Programs") }
  element(:view_credential_programs_element) { |b| b.link(:text=>"View Credential Programs") }
  element(:no_recently_viewed_items_element) { |b| b.div(:id=>"gwt-debug-You-have-no-recently-viewed-items-") }
  element(:course_set_management_element) { |b| b.link(:text=>"Course Set Management") }
  element(:learning_objective_categories_element) { |b| b.link(:text=>"Learning Objective Categories") }
  element(:dependency_analysis_element) { |b| b.link(:text=>"Dependency Analysis") }

  value(:title) { |p| p.title_element.text }

  action(:my_action_list) { |p| p.my_action_list_element.click }
  action(:create_a_course) { |p| p.create_a_course_element.click }
  action(:browse_course_catalogue) { |p| p.browse_course_catalogue_element.click }

end