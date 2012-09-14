# Page classes that are in some way common to both
# the Site context and the My Workspace context.
# 
# == Synopsis
#
# This script defines the page classes that are
# common to both page contexts--within a Site or within My Workspace.
#
# Author :: Abe Heward (aheward@rsmart.com)

#require File.dirname(__FILE__) + '/app_functions.rb'



#================
# Evaluation System Pages
#================

# The "Evaluations Dashboard"
class EvaluationSystem < BasePage

  frame_element
  
  def my_templates
    frm.link(:text=>"My Templates").click
    MyTemplates.new(@browser)
  end
  
  def add_template
    frm.link(:text=>"Add Template").click
    AddTemplateTitle.new(@browser)
  end

  def take_evaluation(evaluation_name)
    frm.div(:class=>"summaryBox").table(:text=>/#{Regexp.escape(evaluation_name)}/).link.click
    TakeEvaluation.new(@browser)
  end
  
  def status_of(evaluation_name)
    return frm.div(:class=>"summaryBox").table(:text=>/#{Regexp.escape(evaluation_name)}/)[1][1].text
  end


  end

# 
class AddTemplateTitle < BasePage

  frame_element
  
  def save
    frm.button(:value=>"Save").click
    EditTemplate.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"title") }
  element(:description) { |b| b.frm.text_area(:id=>"description") }
  end


# 
class EditTemplate < BasePage

  frame_element
  
  def item_text=(text)
    frm.frame(:id, "item-text___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  def new_evaluation
    frm.link(:text=>"New evaluation").click
    frm.frame(:id, "instructions:1:input___Frame").td(:id, "xEditingArea").wait_until_present
    NewEvaluation.new(@browser)
  end

  def add
    frm.button(:value=>"Add").click
    frm.frame(:id, "item-text___Frame").td(:id, "xEditingArea").wait_until_present
  end
  
  def save_item
    frm.button(:value=>"Save item").click
    frm.link(:text=>"New evaluation").wait_until_present
    EditTemplate.new @browser
  end

    element(:item) { |b| b.frm.select_list(:id=>"add-item-control::add-item-classification-selection").click }
  end


# 
class NewEvaluation < BasePage

  frame_element
  
  def continue_to_settings
    frm.button(:value=>"Continue to Settings").click
    EvaluationSettings.new(@browser)
  end
  
  def instructions=(text)
    frm.frame(:id, "instructions:1:input___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

    element(:title) { |b| b.frm.text_field(:id=>"title") }
  end


# 
class EvaluationSettings < BasePage

  frame_element

  def continue_to_assign_to_courses
    frm.button(:value=>"Continue to Assign to Courses").click
    EditEvaluationAssignment.new(@browser)
  end


  end


# 
class EditEvaluationAssignment < BasePage

  frame_element
  
  def save_assigned_groups
    frm.button(:value=>"Save Assigned Groups").click
    ConfirmEvaluation.new(@browser)
  end

  def check_group(title)
    frm.table(:class=>"listHier lines nolines").wait_until_present
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(title)}/).checkbox(:name=>"selectedGroupIDs").set
  end

    action(:assign_to_evaluation_groups) { |b| b.frm.link(:text=>"Assign to Evaluation Groups").click }
  end


#
class ConfirmEvaluation < BasePage

  frame_element
  
  def done
    frm.button(:value=>"Done").click
    MyEvaluations.new(@browser)
  end

end

# 
class MyEvaluations < BasePage

  frame_element


  end

# 
class TakeEvaluation < BasePage

  frame_element
  
  def submit_evaluation
    frm.button(:value=>"Submit Evaluation").click
    EvaluationSystem.new(@browser)
  end


  end


#================
# Overview-type Pages
#================

# Topmost page for a Site in Sakai
class Home < BasePage

  frame_element
  
  # Because the links below are contained within iframes
  # we need the in_frame method in place so that the
  # links can be properly parsed in the PageObject
  # methods for them.
  # Note that the iframes are being identified by their
  # index values on the page. This is a very brittle
  # method for identifying them, but for now it's our
  # only option because both the <id> and <name>
  # tags are unique for every site.
    # Site Information Display, Options button
  action(:site_info_display_options) { |b| b.frm.link(:text=>"Options").click }
    
  end
  
  # Recent Announcements Options button
  action(:recent_announcements_options) { |b| b.frm.link(:text=>"Options").click }
  # Link for New In Forms
  action(:new_in_forums) { |b| b.frm.link(:text=>"New Messages").click }
  element(:number_of_announcements) { |b| b.frm.text_field(:id=>"itemsEntryField") }
  action(:update_announcements) { |b| b.frm.button(:name=>"eventSubmit_doUpdate").click }


  # Gets the text of the displayed announcements, for
  # test case verification
  def announcements_list
    list = []
    links = @browser.frame(:index=>2).links
    links.each { |link| list << link.text }
    list.delete_if { |item| item=="Options" } # Deletes the Options link if it's there.
    return list
  end
  

# The Page that appears when you are not in a particular Site
# Note that this page differs depending on what user is logged in.
# The definitions below include all potential objects. We may
# have to split this class out into user-specific classes.
class MyWorkspace < BasePage

  frame_element

  # Because the links below are contained within iframes
  # we need the in_frame method in place so that the
  # links can be properly parsed in the PageObject
  # methods for them.
  # Note that the iframes are being identified by their
  # index values on the page. This is a very brittle
  # method for identifying them, but for now it's our
  # only option because both the <id> and <name>
  # tags are unique for every site.
    # Calendar Options button
  action(:calendar_options) { |b| b.frm.link(:text=>"Options").click }
  end
  
  # My Workspace Information Options
  action(:my_workspace_information_options) { |b| b.frm.link(:text=>"Options").click }
   # Message of the Day, Options button
  action(:message_of_the_day_options) { |b| b.frm.link(:text=>"Options").click }


  element(:select_page_size) { |b| b.frm.select_list(:id=>"selectPageSize").click }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

  # Returns an array of strings of the Calendar Events listed below
  # the Calendar
  def calendar_events
    events = []
    table = @browser.frame(:class=>"portletMainIframe", :index=>2).table(:id=>"calendarForm:datalist_event_list")
    table.wait_until_present
    table.rows.each do |row|
      events << row.link.text
    end
    return events
  end
  



#================
# Administrative Search Pages
#================

# The Search page in the Administration Workspace - "icon-sakai-search"
class Search < BasePage

  frame_element
  
  action(:admin) { |b| b.frm.link(:text=>"Admin").click }
  element(:search_field) { |b| b.frm.text_field(:id=>"search") }
  action(:search_button) { |b| b.frm.button(:name=>"sb").click }
  element(:this_site) { |b| b.frm.radio(:id=>"searchSite") }
  element(:all_my_sites) { |b| b.frm.radio(:id=>"searchMine") }
    
  end


# The Search Admin page within the Search page in the Admin workspace
class SearchAdmin < BasePage

  frame_element
  
  action(:search) { |b| b.frm.link(:text=>"Search").click }
  action(:rebuild_site_index) { |b| b.frm.link(:text=>"Rebuild Site Index").click }
  action(:refresh_site_index) { |b| b.frm.link(:text=>"Refresh Site Index").click }
  action(:rebuild_whole_index) { |b| b.frm.link(:text=>"Rebuild Whole Index").click }
  action(:refresh_whole_index) { |b| b.frm.link(:text=>"Refresh Whole Index").click }
  action(:remove_lock) { |b| b.frm.link(:text=>"Remove Lock").click }
  action(:reload_index) { |b| b.frm.link(:text=>"Reload Index").click }
  action(:enable_diagnostics) { |b| b.frm.link(:text=>"Enable Diagnostics").click }
  action(:disable_diagnostics) { |b| b.frm.link(:text=>"Disable Diagnostics").click }

  end


#================
# Site Setup/Site Editor Pages
#================

# This module contains the methods referring to the menu items
# across the top of all the Site Editor pages.
module SiteEditorMenu
  
  # Clicks the Edit Tools link, then
  # instantiates the EditSiteTools class.
  def edit_tools
    frm.link(:text=>"Edit Tools").click
    EditSiteTools.new(@browser)
  end
  
  # Clicks the Manage Groups link and
  # instantiates the Groups Class.
  def manage_groups
    frm.link(:text=>"Manage Groups").click
    Groups.new(@browser)
  end
  
  # Clicks the Duplicate Site link and instantiates
  # the DuplicateSite class.
  def duplicate_site
    frm.link(:text=>"Duplicate Site").click
    DuplicateSite.new(@browser)
  end
  
  def add_participants
    frm.link(:text=>"Add Participants").click
    SiteSetupAddParticipants.new @browser
  end
  
end

# The Site Setup page - a.k.a., link class=>"icon-sakai-sitesetup"
class SiteSetup < BasePage

  frame_element

  def search_field
    frm.text_field(:id, "search")
  end

  # Clicks the "New" link on the Site Setup page.
  # instantiates the SiteType class.
  def new
    frm.div(:class=>"portletBody").link(:text=>"New").click
    SiteType.new(@browser)
  end
  
  # Searches for the specified site, then
  # selects the specified Site's checkbox.
  # Then clicks the Edit button and instantiates
  # The SiteSetupEdit class.
  def edit(site_name)
    search_field.value=Regexp.escape(site_name)
    frm.button(:value=>"Search").click
    frm.div(:class=>"portletBody").checkbox(:name=>"selectedMembers").set
    frm.div(:class=>"portletBody").link(:text, "Edit").click
    SiteEditor.new(@browser)
  end

  # Enters the specified site name string in the search
  # field, clicks the Search button, then reinstantiates
  # the Class due to the page refresh.
  def search(site_name)
    search_field.set site_name
    frm.button(:value, "Search").click
    SiteSetup.new(@browser)
  end

  # Searches for the specified site, then
  # checks the site, clicks the delete button,
  # and instantiates the DeleteSite class.
  def delete(site_name)
    search_field.value=site_name
    frm.button(:value=>"Search").click
    frm.checkbox(:name=>"selectedMembers").set
    frm.div(:class=>"portletBody").link(:text, "Delete").click
    DeleteSite.new(@browser)
  end
  
  # Returns an Array object containing strings of
  # all Site titles displayed on the web page.
  def site_titles
    titles = []
    sites_table = frm.table(:id=>"siteList")
    1.upto(sites_table.rows.size-1) do |x|
      titles << sites_table[x][1].text
    end
    return titles
  end
  
  element(:view) { |b| b.frm.select_list(:id=>"view").click }
  action(:clear_search) { |b| b.frm.button(:value=>"Clear Search").click }
  element(:select_page_size) { |b| b.frm.select_list(:id=>"selectPageSize").click }
  action(:sort_by_title) { |b| b.frm.link(:text=>"Worksite Title").click }
  action(:sort_by_type) { |b| b.frm.link(:text=>"Type").click }
  action(:sort_by_creator) { |b| b.frm.link(:text=>"Creator").click }
  action(:sort_by_status) { |b| b.frm.link(:text=>"Status").click }
  action(:sort_by_creation_date) { |b| b.frm.link(:text=>"Creation Date").click }

  end


# The topmost "Site Editor" page,
# found in SITE MANAGEMENT
# or else Site Setup after you have
# selected to Edit a particular site.
class SiteEditor < BasePage

  frame_element

  include SiteEditorMenu
  
  # Sets the specified role for the specified participant.
  #
  # Because the participant is selected using a regular expression,
  # the "participant" string can be anything that will suffice as a
  # unique match--i.e., last name, first name, or user id, or any combination,
  # as long as it will match a part of the string that appears in the
  # desired row.
  def set_role(participant, role)
    frm.table(:class=>/listHier lines/).row(:text=>/#{Regexp.escape(participant)}/).select(:id=>/role/).select(role)
  end
  
  def update_participants
    frm.button(:value=>"Update Participants").click
    SiteEditor.new(@browser)
  end

  def return_button
    frm.button(:name=>"back")
  end

  def return_to_sites_list
    return_button.click
  end

  action(:previous) { |b| b.frm.button(:name=>"previous").click }
  action(:printable_version) { |b| b.frm.link(:text=>"Printable Version").click }
  element(:select_page_size) { |b| b.frm.select_list(:name=>"selectPageSize").click }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

  end


# Groups page inside the Site Editor
class Groups < BasePage

  frame_element

  include SiteEditorMenu
  
  # Clicks the Create New Group link and
  # instantiates the CreateNewGroup Class.
  def create_new_group
    create_new_group_link_element.wait_until_present
    create_new_group_link
    CreateNewGroup.new(@browser)
  end
  
  action(:create_new_group_link) { |b| b.frm.link(:text=>"Create New Group").click }
  action(:auto_groups) { |b| b.frm.link(:text=>"Auto Groups").click }
  action(:remove_checked) { |b| b.frm.button(:id=>"delete-groups").click }
  action(:cancel) { |b| b.frm.button(:id=>"cancel").click }

  end

# The Create New Group page inside the Site Editor
class CreateNewGroup < BasePage

  frame_element
  
  # Clicks the Add button and instantiates the Groups Class.
  def add
    frm.button(:id=>"save").click
    Groups.new(@browser)
  end
  
  element(:title) { |b| b.frm.text_field(:id=>"group_title") }
  element(:description) { |b| b.frm.text_field(:id=>"group_description") }
  element(:site_member_list) { |b| b.frm.select_list(:name=>"siteMembers-selection").click }
  element(:group_member_list) { |b| b.frm.select_list(:name=>"groupMembers-selection").click }
  action(:right) { |b| b.frm.button(:name=>"right", :index=>0,).click }
  action(:left) { |b| b.frm.button(:name=>"left", :index=>0).click }
  action(:all_right) { |b| b.frm.button(:name=>"right", :index=>1).click }
  action(:all_left) { |b| b.frm.button(:name=>"left",:index=>1).click }
  action(:cancel) { |b| b.frm.button(:id=>"cancel").click }

  end

# The first page of the Duplicate Site pages in the Site Editor.
class DuplicateSite < BasePage

  frame_element
   
  def duplicate
    frm.button(:value=>"Duplicate").click
    frm.span(:class=>"submitnotif").wait_while_present(300)
    SiteEditor.new(@browser)
  end

  # Returns the site name in the header, for verification.
  def site_name
    frm.div(:class=>"portletBody").h3.span(:class=>"highlight").text
  end

    element(:site_title) { |b| b.frm.text_field(:id=>"title") }
    element(:academic_term) { |b| b.frm.select_list(:id=>"selectTerm").click }
  end



# Page for Adding Participants to a Site in Site Setup
class SiteSetupAddParticipants < BasePage

  frame_element
  
  def continue
    frm.button(:value=>"Continue").click
    SiteSetupChooseRole.new @browser
  end
  
  element(:official_participants) { |b| b.frm.text_area(:id=>"content::officialAccountParticipant") }
  element(:non_official_participants) { |b| b.frm.text_area(:id=>"content::nonOfficialAccountParticipant") }
  element(:assign_all_to_same_role) { |b| b.frm.radio(:id=>"content::role-row:0:role-select") }
  element(:assign_each_individually) { |b| b.frm.radio(:id=>"content::role-row:1:role-select") }
  element(:active_status) { |b| b.frm.radio(:id=>"content::status-row:0:status-select") }
  element(:inactive_status) { |b| b.frm.radio(:id=>"content::status-row:1:status-select") }
  action(:cancel) { |b| b.frm.button(:id=>"content::cancel").click }
    
  end


# Page for selecting Participant roles individually
class SiteSetupChooseRolesIndiv < BasePage

  frame_element
  
  def continue
    frm.button(:value=>"Continue").click
    #SiteSetupParticipantEmail.new(@browser)
  end
  
  action(:back) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Aback&Fast%20track%20action=siteAddParticipantHandler.processDifferentRoleBack").click }
  action(:cancel) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Acancel&Fast%20track%20action=siteAddParticipantHandler.processCancel").click }
  element(:user_role) { |b| b.frm.select_list(:id=>"content::user-row:0:role-select-selection").click }

  end


# Page for selecting the same role for All. This class is used for
# both Course and Portfolio sites.
class SiteSetupChooseRole < BasePage

  frame_element
  
  def continue
    frm.button(:value=>"Continue").click
    SiteSetupParticipantEmail.new(@browser)
  end
  
  action(:back) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Aback&Fast%20track%20action=siteAddParticipantHandler.processSameRoleBack").click }
  action(:cancel) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Acancel&Fast%20track%20action=siteAddParticipantHandler.processCancel").click }
  element(:guest) { |b| b.frm.radio(:value=>"Guest") }
  element(:instructor) { |b| b.frm.radio(:value=>"Instructor") }
  element(:student) { |b| b.frm.radio(:value=>"Student") }
  element(:evaluator) { |b| b.frm.radio(:value=>"Evaluator") }
  element(:organizer) { |b| b.frm.radio(:value=>"Organizer") }
  element(:participant) { |b| b.frm.radio(:value=>"Participant") }
  element(:reviewer) { |b| b.frm.radio(:value=>"Reviewer") }
  element(:teaching_assistant) { |b| b.frm.radio(:id=>"content::role-row:3:role-select") }

  end


# Page for specifying whether to send an email
# notification to the newly added Site participants
class SiteSetupParticipantEmail < BasePage

  frame_element
  
  def continue
    frm.button(:value=>"Continue").click
    SiteSetupParticipantConfirmation.new(@browser)
  end
  
  action(:back) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Acontinue&Fast%20track%20action=siteAddParticipantHandler.processEmailNotiBack").click }
  action(:cancel) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Acontinue&Fast%20track%20action=siteAddParticipantHandler.processEmailNotiCancel").click }
  element(:send_now) { |b| b.frm.radio(:id=>"content::noti-row:0:noti-select") }
  element(:dont_send) { |b| b.frm.radio(:id=>"content::noti-row:1:noti-select") }
    
  end


# The confirmation page showing site participants and their set roles
class SiteSetupParticipantConfirm < BasePage

  frame_element
  
  def finish
    frm.button(:value=>"Finish").click
    SiteEditor.new(@browser)
  end
  
  # Returns the value of the id field for the specified name.
  def id(name)
    frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(name)}/)[1].text
  end
  
  # Returns the value of the Role field for the specified name.
  def role(name)
    frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(name)}/)[2].text
  end
  
  action(:back) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Aback&Fast%20track%20action=siteAddParticipantHandler.processConfirmBack").click }
  action(:cancel) { |b| b.frm.button(:name=>"command link parameters&Submitting%20control=content%3A%3Aback&Fast%20track%20action=siteAddParticipantHandler.processConfirmCancel").click }

  end

# The Edit Tools page (click on "Edit Tools" when editing a site
# in Site Setup in the Admin Workspace)
class EditSiteTools < BasePage

  frame_element
  
  # Clicks the Continue button.
  action(:continue) { |b| b.frm.button(:value=>"Continue").click }
  
  # This is a comprehensive list of all checkboxes and
  # radio buttons for this page,
  # though not all will appear at one time.
  # The list will depend on the type of site being
  # created/edited.
  checkbox(:all_tools) { |b| b.frm.checkbox(:id=>"all") }
  checkbox(:home) { |b| b.frm.checkbox(:id=>"home") }
  checkbox(:announcements) { |b| b.frm.checkbox(:id=>"sakai.announcements") }
  checkbox(:assignments,) { |b| b.frm.checkbox(:id=>"sakai.assignment.grades") }
  checkbox(:basic_lti) { |b| b.frm.checkbox(:id=>"sakai.basiclti") }
  checkbox(:calendar) { |b| b.frm.checkbox(:id=>"sakai.schedule") }
  checkbox(:email_archive) { |b| b.frm.checkbox(:id=>"sakai.mailbox") }
  checkbox(:evaluations) { |b| b.frm.checkbox(:id=>"osp.evaluation") }
  checkbox(:forms) { |b| b.frm.checkbox(:id=>"sakai.metaobj") }
  checkbox(:glossary) { |b| b.frm.checkbox(:id=>"osp.glossary") }
  checkbox(:matrices) { |b| b.frm.checkbox(:id=>"osp.matrix") }
  checkbox(:news) { |b| b.frm.checkbox(:id=>"sakai.news") }
  checkbox(:portfolio_layouts) { |b| b.frm.checkbox(:id=>"osp.presLayout") }
  checkbox(:portfolio_showcase) { |b| b.frm.checkbox(:id=>"sakai.rsn.osp.iframe") }
  checkbox(:portfolio_templates) { |b| b.frm.checkbox(:id=>"osp.presTemplate") }
  checkbox(:portfolios) { |b| b.frm.checkbox(:id=>"osp.presentation") }
  checkbox(:resources) { |b| b.frm.checkbox(:id=>"sakai.resources") }
  checkbox(:roster) { |b| b.frm.checkbox(:id=>"sakai.site.roster") }
  checkbox(:search) { |b| b.frm.checkbox(:id=>"sakai.search") }
  checkbox(:styles) { |b| b.frm.checkbox(:id=>"osp.style") }
  checkbox(:web_content) { |b| b.frm.checkbox(:id=>"sakai.iframe") }
  checkbox(:wizards) { |b| b.frm.checkbox(:id=>"osp.wizard") }
  checkbox(:blogger) { |b| b.frm.checkbox(:id=>"blogger") }
  checkbox(:blogs) { |b| b.frm.checkbox(:id=>"sakai.blogwow") }
  checkbox(:chat_room) { |b| b.frm.checkbox(:id=>"sakai.chat") }
  checkbox(:discussion_forums) { |b| b.frm.checkbox(:id=>"sakai.jforum.tool") }
  checkbox(:drop_box) { |b| b.frm.checkbox(:id=>"sakai.dropbox") }
  checkbox(:email) { |b| b.frm.checkbox(:id=>"sakai.mailtool") }
  checkbox(:forums) { |b| b.frm.checkbox(:id=>"sakai.forums") }
  checkbox(:certification) { |b| b.frm.checkbox(:id=>"com.rsmart.certification") }
  checkbox(:feedback) { |b| b.frm.checkbox(:id=>"sakai.postem") }
  checkbox(:gradebook) { |b| b.frm.checkbox(:id=>"sakai.gradebook.tool") }
  checkbox(:gradebook2) { |b| b.frm.checkbox(:id=>"sakai.gradebook.gwt.rpc") }
  checkbox(:lesson_builder) { |b| b.frm.checkbox(:id=>"sakai.lessonbuildertool") }
  checkbox(:lessons) { |b| b.frm.checkbox(:id=>"sakai.melete") }
  checkbox(:live_virtual_classroom) { |b| b.frm.checkbox(:id=>"rsmart.virtual_classroom.tool") }
  checkbox(:media_gallery) { |b| b.frm.checkbox(:id=>"sakai.kaltura") }
  checkbox(:messages) { |b| b.frm.checkbox(:id=>"sakai.messages") }
  checkbox(:news) { |b| b.frm.checkbox(:id=>"sakai.news") }
  checkbox(:opensyllabus) { |b| b.frm.checkbox(:id=>"sakai.opensyllabus.tool") }
  checkbox(:podcasts) { |b| b.frm.checkbox(:id=>"sakai.podcasts") }
  checkbox(:polls) { |b| b.frm.checkbox(:id=>"sakai.poll") }
  checkbox(:sections) { |b| b.frm.checkbox(:id=>"sakai.sections") }
  checkbox(:site_editor) { |b| b.frm.checkbox(:id=>"sakai.siteinfo") }
  checkbox(:site_statistics) { |b| b.frm.checkbox(:id=>"sakai.sitestats") }
  checkbox(:syllabus) { |b| b.frm.checkbox(:id=>"sakai.syllabus") }
  checkbox(:tests_and_quizzes_cb) { |b| b.frm.checkbox(:id=>"sakai.samigo") }
  checkbox(:wiki) { |b| b.frm.checkbox(:id=>"sakai.rwiki") }
  element(:no_thanks) { |b| b.frm.radio(:id=>"import_no") }
  element(:yes) { |b| b.frm.radio(:id=>"import_yes") }
  element(:import_sites) { |b| b.frm.select_list(:id=>"importSites").click }
  action(:back) { |b| b.frm.button(:name=>"Back").click }
  action(:cancel) { |b| b.frm.button(:name=>"Cancel").click }
  end
  

class ReUseMaterial < BasePage

  frame_element

  thing(:announcements_checkbox) { |b| b.frm.checkbox(name: "sakai.announcements") }
  thing(:calendar_checkbox) { |b| b.frm.checkbox(name: "sakai.schedule") }
  thing(:discussion_forums_checkbox) { |b| b.frm.checkbox(name: "sakai.jforum.tool") }
  thing(:forums_checkbox) { |b| b.frm.checkbox(name: "sakai.forums") }
  thing(:chat_room_checkbox) { |b| b.frm.checkbox(name: "sakai.chat") }
  thing(:polls_checkbox) { |b| b.frm.checkbox(name: "sakai.poll") }
  thing(:syllabus_checkbox) { |b| b.frm.checkbox(name: "sakai.syllabus") }
  thing(:lessons_checkbox) { |b| b.frm.checkbox(name: "sakai.melete") }
  thing(:resources_checkbox) { |b| b.frm.checkbox(name: "sakai.resources") }
  thing(:assignments_checkbox) { |b| b.frm.checkbox(name: "sakai.assignment.grades") }
  thing(:tests_and_quizzes_checkbox) { |b| b.frm.checkbox(name: "sakai.samigo") }
  thing(:gradebook_checkbox) { |b| b.frm.checkbox(name: "sakai.gradebook.tool") }
  thing(:gradebook2_checkbox) { |b| b.frm.checkbox(name: "sakai.gradebook.gwt.rpc") }
  thing(:wiki_checkbox) { |b| b.frm.checkbox(name: "sakai.rwiki") }
  thing(:news_checkbox) { |b| b.frm.checkbox(name: "sakai.news") }
  thing(:web_content_checkbox) { |b| b.frm.checkbox(name: "sakai.iframe") }
  thing(:site_statistics_checkbox) { |b| b.frm.checkbox(name: "sakai.sitestats") }
  action(:continue) { |b| b.frm.button(name: "eventSubmit_doContinue").click }

end

# Confirmation page when editing site tools in Site Setup
class ConfirmSiteToolsEdits < BasePage

  frame_element

  def finish_button
    frm.button(:value=>"Finish")
  end

  # Clicks the Finish button, then instantiates
  # the SiteSetupEdit class.
  def finish
    finish_button.click
    SiteEditor.new(@browser)
  end
  
end


# The Delete Confirmation Page for deleting a Site
class DeleteSite < BasePage

  frame_element
  
  # Clicks the Remove button, then instantiates
  # the SiteSetup class.
  def remove
    frm.button(:value=>"Remove").click
    SiteSetup.new(@browser)
  end
  
  # Clicks the Cancel button, then instantiates
  # the SiteSetup class.
  def cancel
    frm.button(:value=>"Cancel").click
    SiteSetup.new(@browser)
  end
  
end
#The Site Type page that appears when creating a new site
class SiteType < BasePage

  frame_element

  def continue #FIXME
    if frm.button(:id, "submitBuildOwn").enabled?
      frm.button(:id, "submitBuildOwn").click
    elsif frm.button(:id, "submitFromTemplateCourse").enabled?
      frm.button(:id, "submitFromTemplateCourse").click
    elsif frm.button(:id, "submitFromTemplate").enabled?
      frm.button(:id, "submitFromTemplate").click
    end

  end
  
  element(:course_site) { |b| b.frm.radio(:id=>"course") }
  element(:project_site) { |b| b.frm.radio(:id=>"project") }
  element(:portfolio_site) { |b| b.frm.radio(:id=>"portfolio") }
  element(:create_site_from_template) { |b| b.frm.radio(:id=>"copy") }
  element(:academic_term) { |b| b.frm.select_list(:id=>"selectTerm").click }
  element(:select_template) { |b| b.frm.select_list(:id=>"templateSiteId").click }
  element(:select_term) { |b| b.frm.select_list(:id=>"selectTermTemplate").click }
  action(:cancel) { |b| b.frm.button(:id=>"cancelCreate").click }
  checkbox(:copy_users) { |b| b.frm.checkbox(:id=>"copyUsers") }
  checkbox(:copy_content) { |b| b.frm.checkbox(:id=>"copyContent") }
  end
  

# The Add Multiple Tool Instances page that appears during Site creation
# after the Course Site Tools page
class AddMultipleTools < BasePage

  frame_element
  
  # Clicks the Continue button.
  action(:continue) { |b| b.frm.button(:value=>"Continue").click }

    # Note that the text field definitions included here
    # for the Tools definitions are ONLY for the first
    # instances of each. Since the UI allows for
    # an arbitrary number, if you are writing tests
    # that add more then you're going to have to explicitly
    # reference them or define them in the test case script
    # itself--for now, anyway.
  element(:site_email_address) { |b| b.frm.text_field(:id=>"emailId") }
  element(:basic_lti_title) { |b| b.frm.text_field(:id=>"title_sakai.basiclti") }
  element(:more_basic_lti_tools) { |b| b.frm.select_list(:id=>"num_sakai.basiclti").click }
  element(:lesson_builder_title) { |b| b.frm.text_field(:id=>"title_sakai.lessonbuildertool") }
  element(:more_lesson_builder_tools) { |b| b.frm.select_list(:id=>"num_sakai.lessonbuildertool").click }
  element(:news_title) { |b| b.frm.text_field(:id=>"title_sakai.news") }
  element(:news_url_channel) { |b| b.frm.text_field(:name=>"channel-url_sakai.news") }
  element(:more_news_tools) { |b| b.frm.select_list(:id=>"num_sakai.news").click }
  element(:web_content_title) { |b| b.frm.text_field(:id=>"title_sakai.iframe") }
  element(:web_content_source) { |b| b.frm.text_field(:id=>"source_sakai.iframe") }
  element(:more_web_content_tools) { |b| b.frm.select_list(:id=>"num_sakai.iframe").click }
  action(:back) { |b| b.frm.button(:name=>"Back").click }
  action(:cancel) { |b| b.frm.button(:name=>"Cancel").click }
    
  end
  

# The Course/Section Information page that appears when creating a new Site
class CourseSectionInfo < BasePage

  frame_element
  
  # Clicks the Continue button, then instantiates
  # the CourseSiteInfo Class.
  def continue
    frm.button(:value=>"Continue").click
    CourseSiteInfo.new(@browser)
  end
  
  # Clicks the Done button (or the
  # "Done - go to Site" button if it
  # happens to be there), then instantiates
  # the SiteSetup Class.
  def done
    frm.button(:value=>/Done/).click
    SiteSetup.new(@browser)
  end
  
    # Note that ONLY THE FIRST instances of the
    # subject, course, and section fields
    # are included in the page elements definitions here,
    # because their identifiers are dependent on how
    # many instances exist on the page.
    # This means that if you need to access the second
    # or subsequent of these elements, you'll need to
    # explicitly identify/define them in the test case
    # itself.
  element(:subject) { |b| b.frm.text_field(:name=>/Subject:/) }
  element(:course) { |b| b.frm.text_field(:name=>/Course:/) }
  element(:section) { |b| b.frm.text_field(:name=>/Section:/) }
  element(:authorizers_username) { |b| b.frm.text_field(:id=>"uniqname") }
  element(:special_instructions) { |b| b.frm.text_field(:id=>"additional") }
  element(:add_more_rosters) { |b| b.frm.select_list(:id=>"number").click }
  action(:back,) { |b| b.frm.button(:name=>"Back").click }
  action(:cancel) { |b| b.frm.button(:name=>"Cancel").click }
  end
  

# The Site Access Page that appears during Site creation
# immediately following the Add Multiple Tools Options page.
class SiteAccess < BasePage

  frame_element
  
  # The page element that displays the joiner role
  # select list. Use this method to validate whether the
  # select list is visible or not.
  #
  # Example: page.joiner_role_div.visible?
  def joiner_role_div
    frm.div(:id=>"joinerrole")
  end
  
  # Clicks the Continue button, then
  # instantiates the ConfirmCourseSiteSetup class.
  def continue
    frm.button(:value=>"Continue").click
    ConfirmSiteSetup.new(@browser)
  end
  
  element(:publish_site) { |b| b.frm.radio(:id=>"publish") }
  element(:leave_as_draft) { |b| b.frm.radio(:id=>"unpublish") }
  element(:limited) { |b| b.frm.radio(:id=>"unjoinable") }
  element(:allow) { |b| b.frm.radio(:id=>"joinable") }
  action(:back) { |b| b.frm.button(:name=>"eventSubmit_doBack").click }
  action(:cancel) { |b| b.frm.button(:name=>"eventSubmit_doCancel_create").click }
  element(:joiner_role) { |b| b.frm.select_list(:id=>"joinerRole").click }
  end


# The Confirmation page at the end of a Course Site Setup
class ConfirmSiteSetup < BasePage

  frame_element
  
  # Clicks the Request Site button, then
  # instantiates the SiteSetup Class.
  def request_site
    frm.button(:value=>"Request Site").click
    SiteSetup.new(@browser)
  end
  
  # For portfolio sites...
  # Clicks the "Create Site" button and
  # instantiates the SiteSetup class.
  def create_site
    frm.button(:value=>"Create Site").click
    SiteSetup.new(@browser)
  end
  
end

# The Course Site Information page that appears when creating a new Site
# immediately after the Course/Section Information page
class CourseSiteInfo < BasePage

  frame_element
  include FCKEditor

  def editor
    frm.frame(:id=>"description___Frame")
  end

  def description=(text)
    editor.td(:id, "xEditingArea").frame(:index=>0).send_keys text
  end

  def source=(text)
    editor.td(:id, "xEditingArea").text_field(:class=>"SourceField").set text
  end

  # Clicks the Continue button, then
  # instantiates the EditSiteTools Class.
  def continue
    frm.button(:value=>"Continue").click
    EditSiteTools.new(@browser)
  end
  
  # Gets the text contained in the alert box
  # on the web page.
  def alert_box_text
    frm.div(:class=>"portletBody").div(:class=>"alertMessage").text
  end
  
  element(:short_description) { |b| b.frm.text_field(:id=>"short_description") }
  element(:special_instructions) { |b| b.frm.text_field(:id=>"additional") }
  element(:site_contact_name) { |b| b.frm.text_field(:id=>"siteContactName") }
  element(:site_contact_email) { |b| b.frm.text_field(:id=>"siteContactEmail") }
  action(:back) { |b| b.frm.button(:name=>"Back").click }
  action(:cancel) { |b| b.frm.button(:name=>"Cancel").click }
  end
  

# 
class PortfolioSiteInfo < BasePage

  frame_element

  def description=(text)
    frm.frame(:id, "description___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end
  
  def continue
    frm.button(:value=>"Continue").click
    PortfolioSiteTools.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"title") }
  element(:url_alias) { |b| b.frm.text_field(:id=>"alias_0") }
  element(:short_description) { |b| b.frm.text_area(:id=>"short_description") }
  element(:icon_url) { |b| b.frm.text_field(:id=>"iconUrl") }
  element(:site_contact_name) { |b| b.frm.text_field(:id=>"siteContactName") }
  element(:site_contact_email) { |b| b.frm.text_field(:id=>"siteContactEmail") }
  end

# 
class PortfolioSiteTools < BasePage

  frame_element

  def continue
    frm.button(:value=>"Continue").click
    PortfolioConfigureToolOptions.new(@browser)
  end

  checkbox(:all_tools) { |b| b.frm.checkbox(:id=>"all") }
    
  end

# 
class PortfolioConfigureToolOptions < BasePage

  frame_element
  
  def continue
    frm.button(:value=>"Continue").click
    SiteAccess.new(@browser)
  end

  element(:email) { |b| b.frm.text_field(:id=>"emailId") }
  end


