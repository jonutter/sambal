#================
# Users Pages - From the Workspace
#================

# The Page for editing User Account details
class EditUser < BasePage

  frame_element

  def update_details
    frm.button(:name=>"eventSubmit_doSave").click
    sleep 1
  end

  action(:remove_user) { |b| b.frm.link(text=>"Remove User").click }
  element(:first_name) { |b| b.frm.text_field(:id=>"first-name") }
  element(:last_name) { |b| b.frm.text_field(:id=>"last-name") }
  element(:email) { |b| b.frm.text_field(:id=>"email") }
  element(:create_new_password) { |b| b.frm.text_field(:id=>"pw") }
  element(:verify_new_password) { |b| b.frm.text_field(:id=>"pw0") }
  action(:cancel_changes) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }

end

# The Users page - "icon-sakai-users"
class Users < BasePage

  frame_element

  def new_user
    frm.link(:text=>"New User").click
    CreateNewUser.new @browser
  end

  # Returns the contents of the Name cell
  # based on the specified user ID value.
  def name(user_id)
    frm.table(:class=>"listHier lines").row(:text=>/#{Regexp.escape(user_id)}/i)[1].text
  end

  # Returns the contents of the Email cell
  # based on the specified user ID value.
  def email(user_id)
    frm.table(:class=>"listHier lines").row(:text=>/#{Regexp.escape(user_id)}/i)[2].text
  end

  # Returns the contents of the Type cell
  # based on the specified user ID value.
  def type(user_id)
    frm.table(:class=>"listHier lines").row(:text=>/#{Regexp.escape(user_id)}/i)[3].text
  end

  def search_button
    frm.link(:text=>"Search").click
    frm.table(:class=>"listHier lines").wait_until_present
    Users.new @browser
  end

  action(:clear_search) { |b| b.frm.link(text=>"Clear Search").click }
  element(:search_field) { |b| b.frm.text_field(:id=>"search") }
  element(:select_page_size) { |b| b.frm.select_list(:name=>"selectPageSize") }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

end


# The Create New User page
class CreateNewUser < BasePage

  frame_element

  def save_details
    frm.button(:name=>"eventSubmit_doSave").click
    Users.new(@browser)
  end

  element(:user_id) { |b| b.frm.text_field(:id=>"eid") }
  element(:first_name) { |b| b.frm.text_field(:id=>"first-name") }
  element(:last_name) { |b| b.frm.text_field(:id=>"last-name") }
  element(:email) { |b| b.frm.text_field(:id=>"email") }
  element(:create_new_password) { |b| b.frm.text_field(:id=>"pw") }
  element(:verify_new_password) { |b| b.frm.text_field(:id=>"pw0") }
  element(:type) { |b| b.frm.select_list(:name=>"type") }
  action(:cancel_changes) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }
end