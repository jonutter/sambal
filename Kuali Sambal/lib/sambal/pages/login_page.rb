class Login < PageMaker

  page_url "#{TEST_SITE}/login.jsp"

  crucial_element(:username_field) { |b| b.text_field(:name=>"j_username") }
  crucial_element(:password_field) { |b| b.text_field(:name=>"j_password") }
  crucial_element(:login_button) { |b| b.button(:value=>"Login") }

  def login_with username, password
    username_field.set username
    password_field.set password
    login_button.click
  end

end