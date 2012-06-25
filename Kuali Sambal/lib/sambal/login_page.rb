class KualiStudent::Login < PageMaker

  element(:username) { |b| b.text_field(:name=>"j_username") }
  element(:password) { |b| b.text_field(:name=>"j_password") }

  action(:login) { |b| b.button(:value=>"Login").click }

end