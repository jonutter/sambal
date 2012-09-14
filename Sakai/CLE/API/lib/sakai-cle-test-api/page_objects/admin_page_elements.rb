# Navigation links in Sakai's non-site pages
# 
# == Synopsis
#
# Defines all objects in Sakai Pages that are found in the
# context of the Admin user, in "My Workspace". No classes in this
# script should refer to pages that appear in the context of
# a particular Site, even though, as in the case of Resources,
# Announcements, and Help, the page may exist in both contexts.
#
# Most classes use the PageObject gem
# to create methods to interact with the objects on the pages.
#
# Author :: Abe Heward (aheward@rsmart.com)

# Page-object is the gem that parses each of the listed objects.
# For an introduction to the tool, written by the author, visit:
# http://www.cheezyworld.com/2011/07/29/introducing-page-object-gem/
#
# For more extensive detail, visit:
# https://github.com/cheezy/page-object/wiki/page-object
#
# Also, see the bottom of this script for a Page Class template for
# copying when you create a new class.

#require 'page-object'
#require  File.dirname(__FILE__) + '/app_functions.rb'

#================
# Aliases Pages
#================

# The Aliases page - "icon-sakai-aliases", found in the Administration Workspace
class Aliases < BasePage

  frame_element

element(:new_alias) { |b| b.frm.link(:text=>"New Alias") }
  text_field(:search_field, :id=>"search")
  action(:search_button) { |b| b.frm.link(:text=>"Search").click }
element(:select_page_size) { |b| b.frm.select(:id=>"selectPageSize") }
  button(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  button(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  button(:previous) { |b| b.frm.button(name=>"eventSubmit_doList_prev").click }
  button(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

end

# The Page that appears when you create a New Alias
class AliasesCreate < BasePage

  frame_element


  text_field(:alias_name, :id=>"id")
  text_field(:target, :id=>"target")
  button(:save) { |b| b.frm.button(:name=>"eventSubmit_doSave").click }
  button(:cancel) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }

end

# Page for editing an existing Alias record
class EditAlias < BasePage

  frame_element

  action(:remove_alias) { |b| b.frm.link(:text=>"Remove Alias").click }
  text_field(:target, :id=>"target")
  button(:save) { |b| b.frm.button(:name=>"eventSubmit_doSave").click }
  button(:cancel) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }

end


#================
# Login Pages
#================

# This is the page where users log in to the site.
class Login < BasePage

  frame_element

  def search_public_courses_and_projects
    @browser.frame(:index=>0).link(:text=>"Search Public Courses and Projects").click
    SearchPublic.new(@browser)
  end

  # Logs in to Sakai using the
  # specified credentials. Then it
  # instantiates the MyWorkspace class.
  def login(username, password)
    frame = @browser.frame(:id, "ifrm")
    frame.text_field(:id, "eid").set username
    frame.text_field(:id, "pw").set password
    frame.form(:method, "post").submit
    return MyWorkspace.new(@browser)
  end
  alias log_in login
  alias sign_in login

end

# The page where you search for public courses and projects.
class SearchPublic < BasePage

  frame_element

  def home
    @browser.frame(:index=>0).link(:text=>"Home").click
    Login.new(@browser)
  end

  def search_for=(string)
    @browser.frame(:index=>0).text_field(:id=>"searchbox").set(Regexp.escape(string))
  end

  def search_for_sites
    @browser.frame(:index=>0).button(:value=>"Search for Sites").click
    SearchPublicResults.new(@browser)
  end

end

# The page showing the results list of Site matches to a search of public sites/projects.
class SearchPublicResults < BasePage

  frame_element

  def click_site(site_name)
    @browser.frame(:index=>0).link(:text=>site_name).click
    SiteSummaryPage.new(@browser)
  end

  def home
    @browser.frame(:id=>"ifrm").link(:text=>"Home").click
    Login.new(@browser)
  end

end

# The page that appears when you click a Site in the Site Search Results page, when not logged
# in to Sakai.
class SiteSummaryPage < BasePage

  frame_element

  def return_to_list
    @browser.frame(:index=>0).button(:value=>"Return to List").click
    SearchPublicResults.new(@browser)
  end

  def syllabus_attachments
    links = []
    @browser.frame(:id=>"ifrm").links.each do |link|
      if link.href=~/Syllabus/
        links << link.text
      end
    end
    return links
  end

end


#================
# Realms Pages
#================

# Realms page
class Realms < BasePage

  frame_element

  action(:new_realm) { |b| b.frm.link(:text=>"New Realm").click }
  action(:search) { |b| b.frm.link(:text=>"Search").click }
  select_list(:select_page_size, :name=>"selectPageSize")
  button(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  button(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  button(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  button(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

end

#================
# Sections - Site Management
#================

# The Add Sections Page in Site Management
class AddSections < BasePage

  frame_element

  action(:overview) { |b| b.frm.link(:id=>"addSectionsForm:_idJsp3").click }
  action(:student_memberships) { |b| b.frm.link(:id=>"addSectionsForm:_idJsp12").click }
  action(:options) { |b| b.frm.link(:id=>"addSectionsForm:_idJsp17").click }
  select_list(:num_to_add, :id=>"addSectionsForm:numToAdd")
  select_list(:category, :id=>"addSectionsForm:category")
  button(:add_sections, :id=>"addSectionsForm:_idJsp89").click }
  button(:cancel, :id=>"addSectionsForm:_idJsp90").click }


    # Note that the following field definitions are appropriate for
    # ONLY THE FIRST instance of each of the fields. The Add Sections page
    # allows for an arbitrary number of these fields to exist.
    # If you are going to test the addition of multiple sections
    # and/or meetings, then their elements will have to be
    # explicitly called or defined in the test scripts themselves.
  text_field(:name, :id=>"addSectionsForm:sectionTable:0:titleInput")
  radio_button(:unlimited_size, :name=>"addSectionsForm:sectionTable:0:limit", :index=>0)
  radio_button(:limited_size, :name=>"addSectionsForm:sectionTable:0:limit", :index=>1)
  text_field(:max_enrollment, :id=>"addSectionsForm:sectionTable:0:maxEnrollmentInput")
  checkbox(:monday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:monday")
  checkbox(:tuesday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:tuesday")
  checkbox(:wednesday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:wednesday")
  checkbox(:thursday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:thursday")
  checkbox(:friday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:friday")
  checkbox(:saturday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:saturday")
  checkbox(:sunday, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:sunday")
  text_field(:start_time, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTime")
  radio_button(:start_am, :name=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm", :index=>0)
  radio_button(:start_pm, :name=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm", :index=>1)
  text_field(:end_time, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTime")
  radio_button(:end_am, :name=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm", :index=>0)
  radio_button(:end_pm, :name=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm", :index=>1)
  text_field(:location, :id=>"addSectionsForm:sectionTable:0:meetingsTable:0:location")
  action(:add_days) { |b| b.frm.link(:id=>"addSectionsForm:sectionTable:0:addMeeting").click }

  end


# Exactly like the Add Sections page, but used when editing an existing section
class EditSections < BasePage

  frame_element

  action(:overview) { |b| b.frm.link(:id=>"editSectionsForm:_idJsp3").click }
  action(:student_memberships) { |b| b.frm.link(:id=>"editSectionsForm:_idJsp12").click }
  action(:options) { |b| b.frm.link(:id=>"editSectionsForm:_idJsp17").click }
  select_list(:num_to_add, :id=>"editSectionsForm:numToAdd")
  select_list(:category, :id=>"editSectionsForm:category")
  button(:add_sections) { |b| b.frm.button(:id=>"editSectionsForm:_idJsp89").click }
  button(:cancel) { |b| b.frm.button(:id=>"editSectionsForm:_idJsp90").click }

  # Note that the following field definitions are appropriate for
  # ONLY THE FIRST instance of each of the fields. The Edit Sections page
  # allows for an arbitrary number of these fields to exist.
  # If you are going to test the editing of multiple sections
  # and/or meetings, then their elements will have to be
  # explicitly called or defined in the test scripts themselves.
  text_field(:name, :id=>"editSectionsForm:sectionTable:0:titleInput")
  radio_button(:unlimited_size, :name=>"editSectionsForm:sectionTable:0:limit", :index=>0)
  radio_button(:limited_size, :name=>"editSectionsForm:sectionTable:0:limit", :index=>1)
  text_field(:max_enrollment, :id=>"editSectionsForm:sectionTable:0:maxEnrollmentInput")
  checkbox(:monday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:monday")
  checkbox(:tuesday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:tuesday")
  checkbox(:wednesday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:wednesday")
  checkbox(:thursday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:thursday")
  checkbox(:friday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:friday")
  checkbox(:saturday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:saturday")
  checkbox(:sunday, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:sunday")
  text_field(:start_time, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTime")
  radio_button(:start_am, :name=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm", :index=>0)
  radio_button(:start_pm, :name=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm", :index=>1)
  text_field(:end_time, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTime")
  radio_button(:end_am, :name=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm", :index=>0)
  radio_button(:end_pm, :name=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm", :index=>1)
  text_field(:location, :id=>"editSectionsForm:sectionTable:0:meetingsTable:0:location")
  action(:add_days) { |b| b.frm.link(:id=>"editSectionsForm:sectionTable:0:addMeeting").click }

  end


# Options page for Sections
class SectionsOptions < BasePage

  frame_element

  checkbox(:students_can_sign_up, :id=>"optionsForm:selfRegister")
  checkbox(:students_can_switch_sections, :id=>"optionsForm:selfSwitch")
  button(:update) { |b| b.frm.button(:id=>"optionsForm:_idJsp50").click }
  button(:cancel) { |b| b.frm.button(:id=>"optionsForm:_idJsp51").click }
  action(:overview) { |b| b.frm.link(:id=>"optionsForm:_idJsp3").click }
  action(:add_sections) { |b| b.frm.link(:id=>"optionsForm:_idJsp8").click }
  action(:student_memberships) { |b| b.frm.link(:id=>"optionsForm:_idJsp12").click }

  end


# The Sections page
# found in the SITE MANAGEMENT menu for a Site
class SectionsOverview < BasePage

  frame_element

  action(:add_sections) { |b| b.frm.link(:id=>"overviewForm:_idJsp8").click }
  action(:student_memberships) { |b| b.frm.link(:id=>"overviewForm:_idJsp12").click }
  action(:options) { |b| b.frm.link(:id=>"overviewForm:_idJsp17").click }
  action(:sort_name) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp54").click }
  action(:sort_ta) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp73").click }
  action(:sort_day) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp78").click }
  action(:sort_time) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp83").click }
  action(:sort_location) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp88").click }
  action(:sort_current_size) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp93").click }
  action(:sort_avail) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp97").click }

  end


#================
# Sites Page - from Administration Workspace
#================

# Sites page - arrived at via the link with class="icon-sakai-sites"
class Sites < BasePage

  frame_element

  # Clicks the first site Id link
  # listed. Useful when you've run a search and
  # you're certain you've got the result you want.
  # It then instantiates the EditSiteInfo page class.
  def click_top_item
    frm.link(:href, /#{Regexp.escape("&panel=Main&sakai_action=doEdit")}/).click
    EditSiteInfo.new(@browser)
  end

  # Clicks the specified Site in the list, using the
  # specified id value to determine which item to click.
  # It then instantiates the EditSiteInfo page class.
  # Use this method when you know the target site ID.
  def edit_site_id(id)
    frm.text_field(:id=>"search_site").value=id
    frm.link(:text=>"Site ID").click
    frm.link(:text, id).click
    EditSiteInfo.new(@browser)
  end

  # Clicks the New Site button, then instantiates
  # the EditSiteInfo page class.
  def new_site
    frm.link(:text, "New Site").click
    EditSiteInfo.new(@browser)
  end

  text_field(:search_field, :id=>"search")
  action(:search_button) { |b| b.frm.link(text=>"Search").click }
  text_field(:search_site_id, :id=>"search_site")
  action(:search_site_id_button) { |b| b.frm.link(text=>"Site ID").click }
  text_field(:search_user_id, :id=>"search_user")
  action(:search_user_id_button) { |b| b.frm.link(text=>"User ID").click }
  button(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  button(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  button(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  button(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }
  select_list(:select_page_size, :name=>"selectPageSize")
  button(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  button(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  button(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  button(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }
  end


# Page that appears when you've clicked a Site ID in the
# Sites section of the Administration Workspace.
class EditSiteInfo < BasePage

  frame_element

  # Clicks the Remove Site button, then instantiates
  # the RemoveSite page class.
  def remove_site
    frm.link(:text, "Remove Site").click
    RemoveSite.new(@browser)
  end

  # Clicks the Save button, then instantiates the Sites
  # page class.
  def save
    frm.button(:value=>"Save").click
    Sites.new(@browser)
  end

  # Clicks the Save As link, then instantiates
  # the SiteSaveAs page class.
  def save_as
    frm.link(:text, "Save As").click
    SiteSaveAs.new(@browser)
  end

  # Gets the Site ID from the page.
  def site_id_read_only
    @browser.frame(:index=>0).table(:class=>"itemSummary").td(:class=>"shorttext", :index=>0).text
  end

  # Enters the specified text string in the text area of
  # the FCKEditor.
  def description=(text)
    editor.td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # The FCKEditor object. Use this object for
  # wait commands when the site is slow
  def editor
    @browser.frame(:index=>0).frame(:id, "description___Frame")
  end

  # Clicks the Properties button on the page,
  # then instantiates the AddEditSiteProperties
  # page class.
  def properties
    frm.button(:value=>"Properties").click
    AddEditSiteProperties.new(@browser)
  end

  # Clicks the Pages button, then instantiates
  # the AddEditPages page class.
  def pages
    frm.button(:value=>"Pages").click
    AddEditPages.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    # Non-navigating, interactive page objects go here
    text_field(:site_id, :id=>"id")
    text_field(:title, :id=>"title")
    text_field(:type, :id=>"type")
    text_area(:short_description, :id=>"shortDescription")
    radio_button(:unpublished, :id=>"publishedfalse")
    radio_button(:published, :id=>"publishedtrue")
    radio_button(:public_view_yes, :id=>"pubViewtrue")
  end

end

# The page you come to when editing a Site in Sites
# and you click on the Pages button
class AddEditPages < BasePage

  frame_element

  # Clicks the link for New Page, then
  # instantiates the NewPage page class.
  def new_page
    frm.link(:text=>"New Page").click
    NewPage.new(@browser)
  end

end

# Page for adding a new page to a Site.
class NewPage < BasePage

  frame_element

  # Clicks the Tools button, then instantiates
  # the AddEditTools class.
  def tools
    frm.button(:value=>"Tools").click
    AddEditTools.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    # Interactive page objects that do no navigation
    # or page refreshes go here.
    text_field(:title, :id=>"title")
  end

end

# Page when editing a Site and adding/editing tools for pages.
class AddEditTools < BasePage

  frame_element

  # Clicks the New Tool link, then instantiates
  # the NewTool class.
  def new_tool
    frm.link(:text=>"New Tool").click
    NewTool.new(@browser)
  end

  # Clicks the Save button, then
  # instantiates the AddEditPages class.
  def save
    frm.button(:value=>"Save").click
    AddEditPages.new(@browser)
  end

end

# Page for creating a new tool for a page in a site
class NewTool < BasePage

  frame_element

  # Clicks the Done button, the instantiates
  # The AddEditTools class.
  def done
    frm.button(:value=>"Done").click
    AddEditTools.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    # Interactive page objects that do no navigation
    # or page refreshes go here.
    text_field(:title, :id=>"title")
    text_field(:layout_hints, :id=>"layoutHints")
    radio_button(:resources, :id=>"feature80")
  end

end

# Page that appears when you click "Remove Site" when editing a Site in Sites
class RemoveSite < BasePage

  frame_element

  # Clicks the Remove button, then
  # instantiates the Sites class.
  def remove
    frm.button(:value=>"Remove").click
    Sites.new(@browser)
  end

end

# Page that appears when you click "Save As" when editing a Site in Sites
class SiteSaveAs < BasePage

  frame_element

  # Clicks the Save button, then
  # instantiates the Sites class.
  def save
    frm.button(:value, "Save").click
    Sites.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:site_id, :id=>"id")
  end

end

class AddEditSiteProperties < BasePage

  frame_element

  # Clicks the New Property button
  def new_property
    frm.button(:value=>"New Property").click
    #Class.new(@browser)
  end

  # Clicks the Done button, then instantiates
  # the EditSiteInfo class.
  def done
    frm.button(:value=>"Done").click
    EditSiteInfo.new(@browser)
  end

  # Clicks the Save button, then instantiates
  # the Sites page class.
  def save
    frm.button(:value=>"Save").click
    Sites.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:name, :id=>"new_name")
    text_field(:value, :id=>"new_value")
  end
end



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

  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:first_name, :id=>"first-name")
    text_field(:last_name, :id=>"last-name")
    text_field(:email, :id=>"email")
    text_field(:current_password, :id=>"pwcur")
    text_field(:create_new_password, :id=>"pw")
    text_field(:verify_new_password, :id=>"pw0")
  end

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
  text_field(:first_name, :id=>"first-name")
  text_field(:last_name, :id=>"last-name")
  text_field(:email, :id=>"email")
  text_field(:create_new_password, :id=>"pw")
  text_field(:verify_new_password, :id=>"pw0")
  button(:cancel_changes) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }
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

  in_frame(:class=>"portletMainIframe") do |frame|
    action(:clear_search) { |b| b.frm.link(text=>"Clear Search").click }
    text_field(:search_field, :id=>"search")
    select_list(:select_page_size, :name=>"selectPageSize")
    button(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
    button(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
    button(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
    button(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }
  end

end

# The Create New User page
class CreateNewUser < BasePage

  frame_element

  def save_details
    frm.button(:name=>"eventSubmit_doSave").click
    Users.new(@browser)
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:user_id, :id=>"eid")
    text_field(:first_name, :id=>"first-name")
    text_field(:last_name, :id=>"last-name")
    text_field(:email, :id=>"email")
    text_field(:create_new_password, :id=>"pw")
    text_field(:verify_new_password, :id=>"pw0")
    select_list(:type, :name=>"type")
    button(:cancel_changes) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }
  end



#================
# User Membership Pages from Administration Workspace
#================

# User Membership page for admin users - "icon-sakai-usermembership"
class UserMembership < BasePage

  frame_element

  # Returns an array containing the user names displayed in the search results.
  def names
    names = []
    frm.table(:class=>/listHier/).rows.each do |row|
      names << row[2].text
    end
    names.delete_at(0)
    return names
  end

  # Returns the user id of the specified user (assuming that person
  # appears in the search results list, otherwise this method will
  # throw an error.)
  def user_id(name)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(name)}/)[0].text
  end

  # Returns the user type of the specified user (assuming that person
  # appears in the search results list, otherwise this method will
  # throw an error.)
  def type(name)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(name)}/)[4].text
  end

  # Returns the text contents of the "instruction" paragraph that
  # appears when there are no search results.
  def alert_text
    frm.p(:class=>"instruction").text
  end

  select_list(:user_type, :id=>"userlistForm:selectType")
  select_list(:user_authority, :id=>"userlistForm:selectAuthority")
  text_field(:search_field, :id=>"userlistForm:inputSearchBox")
  button(:search) { |b| b.frm.button(:id=>"userlistForm:searchButton").click }
  button(:clear_search) { |b| b.frm.button(:id=>"userlistForm:clearSearchButton").click }
  select_list(:page_size, :id=>"userlistForm:pager_pageSize")
  button(:export_csv) { |b| b.frm.button(:id=>"userlistForm:exportCsv").click }
  button(:export_excel) { |b| b.frm.button(:id=>"userlistForm:exportXls").click }
  action(:sort_user_id) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp14").click }
  action(:sort_internal_user_id) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp18").click }
  action(:sort_name) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp21").click }
  action(:sort_email) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp24").click }
  action(:sort_type) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp28".click }
  action(:sort_authority) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp31").click }
  action(:sort_created_on) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp34").click }
  action(:sort_modified_on) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp37").click }
  #(:, =>"")
    
  end


#================
# Job Scheduler pages in Admin Workspace
#================

# The topmost page in the Job Scheduler in Admin Workspace
class JobScheduler < BasePage

  frame_element
  
  # Clicks the Jobs link, then instantiates
  # the JobList Class.
  def jobs
    frm.link(:text=>"Jobs").click
    JobList.new(@browser)
  end
  
end

# The list of Jobs (click the Jobs button on Job Scheduler)
class JobList < BasePage

  frame_element
  
  # Clicks the New Job link, then
  # instantiates the CreateNewJob Class.
  def new_job
    frm.link(:text=>"New Job").click
    CreateNewJob.new(@browser)
  end
  
  # Clicks the link with the text "Triggers" associated with the
  # specified job name, 
  # then instantiates the EditTriggers Class.
  def triggers(job_name)
    frm.div(:class=>"portletBody").table(:class=>"listHier lines").row(:text=>/#{Regexp.escape(job_name)}/).link(:text=>/Triggers/).click
    sleep 1
    EditTriggers.new(@browser)
  end
  
  def event_log
    frm.link(:text=>"Event Log").click
    EventLog.new(@browser)
  end
  
end

# The Create New Job page
class CreateNewJob < BasePage

  frame_element

  # Clicks the Post button, then
  # instantiates the JobList Class.
  def post
    frm.button(:value=>"Post").click
    JobList.new(@browser)
  end
  
  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:job_name, :id=>"_id2:job_name")
    select_list(:type, :name=>"_id2:_id10")
  end
end

# The page for Editing Triggers
class EditTriggers < BasePage

  frame_element
  
  # Clicks the "Run Job Now" link, then
  # instantiates the RunJobConfirmation Class.
  def run_job_now
    frm.div(:class=>"portletBody").link(:text=>"Run Job Now").click
    RunJobConfirmation.new(@browser)
  end
  
  def return_to_jobs
    frm.link(:text=>"Return_to_Jobs").click
    JobList.new(@browser)
  end
  
  def new_trigger
    frm.link(:text=>"New Trigger").click
    CreateTrigger.new(@browser)
  end

end

# The Create Trigger page
class CreateTrigger < BasePage

  frame_element
  
  def post
    frm.button(:value=>"Post").click
    EditTriggers.new(@browser)
  end

  in_frame(:index=>0) do |frame|
    text_field(:name, :id=>"_id2:trigger_name")
    text_field(:cron_expression, :id=>"_id2:trigger_expression")
  end
end


# The page for confirming you want to run a job
class RunJobConfirmation < BasePage

  frame_element
  
  # Clicks the "Run Now" button, then
  # instantiates the JobList Class.
  def run_now
    frm.button(:value=>"Run Now").click
    JobList.new(@browser)
  end

end

# The page containing the Event Log
class EventLog
  
  include PageObject
  include ToolsMenu

end