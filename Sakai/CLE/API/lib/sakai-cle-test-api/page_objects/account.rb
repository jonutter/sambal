#================
# User's Account Page - in "My Settings"
#================

# The Page for editing User Account details
class EditAccount < BasePage

  frame_element

  # Clicks the update details button then
  # makes sure there isn't any error message present.
  # If there is, it reinstantiates the Edit Account Class,
  # otherwise it instantiates the UserAccount Class.
  def update_details
    frm.button(:value=>"Update Details").click
    # Need to check if the update took...
    if frm.div(:class=>"portletBody").h3.text=="My Account Details"
      # Apparently it did...
      UserAccount.new(@browser)
    elsif frm.div(:class=>"portletBody").h3.text=="Account Details"
      # We are on the edit page (or we're using the Admin account)...
      EditAccount.new(@browser)
    elsif frm.div(:class=>"portletBody").h3.text=="Users"
      Users.new(@browser)
    end
  end

  element(:first_name) { |b| b.frm.text_field(:id=>"first-name") }
  element(:last_name) { |b| b.frm.text_field(:id=>"last-name") }
  element(:email) { |b| b.frm.text_field(:id=>"email") }
  element(:current_password) { |b| b.frm.text_field(:id=>"pwcur") }
  element(:create_new_password) { |b| b.frm.text_field(:id=>"pw") }
  element(:verify_new_password) { |b| b.frm.text_field(:id=>"pw0") }
end


# A Non-Admin User's Account page
# Accessible via the "Account" link in "MY SETTINGS"
#
# IMPORTANT: this class does not use PageObject or the ToolsMenu!!
# So, the only available method to navigate away from this page is
# Home. Otherwise, you'll have to call the navigation link
# Explicitly in the test case itself.
#
# Objects and methods used in this class must be explicitly
# defined using Watir and Ruby code.
#
# Do NOT use the PageObject syntax in this class.
class UserAccount < BasePage

  frame_element

  # Clicks the Modify Details button. Instantiates the EditAccount class.
  def modify_details
    @browser.frame(:index=>0).button(:name=>"eventSubmit_doModify").click
    EditAccount.new(@browser)
  end

  # Gets the text of the User ID field.
  def user_id
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>0)[0][1].text
  end

  # Gets the text of the First Name field.
  def first_name
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>0)[1][1].text
  end

  # Gets the text of the Last Name field.
  def last_name
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>0)[2][1].text
  end

  # Gets the text of the Email field.
  def email
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>0)[3][1].text
  end

  # Gets the text of the Type field.
  def type
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>0)[4][1].text
  end

  # Gets the text of the Created By field.
  def created_by
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>1)[0][1].text
  end

  # Gets the text of the Created field.
  def created
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>1)[1][1].text
  end

  # Gets the text of the Modified By field.
  def modified_by
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>1)[2][1].text
  end

  # Gets the text of the Modified (date) field.
  def modified
    @browser.frame(:index=>0).table(:class=>"itemSummary", :index=>1)[3][1].text
  end

  # Clicks the Home buton in the left menu.
  # instantiates the Home Class.
  def home
    @browser.link(:text, "Home").click
    Home.new(@browser)
  end

end