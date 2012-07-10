class MainMenu < BasePage

  page_url "#{TEST_SITE}/portal.do"
  expected_title "Kuali Portal Index"

  wrapper_elements

  action(:enrollment) { |b| b.link(title: "Enrollment (in progress)").click }

end