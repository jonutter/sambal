class KualiStudent::Login < PageMaker

  page_url "http://env1.ks.kuali.org/login.jsp" # TODO: This needs to be defined by a config variable, not hard-coded.

  element(:username_field) { |b| b.text_field(:name=>"j_username") }
  element(:password_field) { |b| b.text_field(:name=>"j_password") }
  element(:login_button) { |b| b.button(:value=>"Login") }

  def login_with username, password
    username_field.set username
    password_field.set password
    login_button.click
  end

end