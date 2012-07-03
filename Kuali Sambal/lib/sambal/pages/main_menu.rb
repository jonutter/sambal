class MainMenu < BasePage

  page_url "#{TEST_SITE}/portal.do"
  expected_title "Kuali Portal Index"

  header_elements
  footer_elements

  action(:enrollment) { |b| b.link(title: "Enrollment (in progress)").click }

end