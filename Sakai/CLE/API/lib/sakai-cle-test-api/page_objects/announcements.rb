# The Announcements list page for a Site.
class Announcements < BasePage

  frame_element

  # Clicks the add button, goes to the AddEditAnnouncements class.
  action(:add) { |b| b.frm.div(:class=>"portletBody").link(:title=>"Add").click }

  # Edits the specified announcement in the list.
  # @param subject [String] the text of the announcement listing link.
  def edit(subject)
    frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(subject)}/).link(:text=>"Edit").click
    AddEditAnnouncements.new(@browser)
  end

  # Returns an array of the subject strings of the announcements
  # listed on the page.
  def subjects
    links = frm.table(:class=>"listHier").links.find_all { |link| link.title=~/View announcement/ }
    subjects = []
    links.each { |link| subjects << link.text }
    return subjects
  end

  def href(subject)
    frm.link(:text=>subject).href
  end

  # Returns true or false depending on whether the specified announcement has an attachment.
  # @param subject [String] the text of the announcement listing link.
  def has_attachment?(subject)
    if frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(subject)}/).exist?
      return frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(subject)}/).image(:alt=>"attachment").exist?
    else
      puts "Can't find your target row. Your test is faulty."
      return false
    end
  end

  # Returns the text of the "For" column for
  # the specified announcement.
  # @param subject [String] the text of the announcement listing link.
  def for_column(subject)
    frm.table(:class=>"listHier").row(:text=>/#{Regexp.escape(subject)}/)[4].text
  end

  # Clicks the specified announcement link and instantiates the PreviewAnnouncements class.
  # @param subject [String] the text of the announcement listing link.
  def preview_announcement(subject)
    frm.link(:text=>subject).click
    PreviewAnnouncements.new(@browser)
  end

  # Selects the specified list item from the View selection list.
  # @param list_item [String] the text of the option in the selection list.
  def view=(list_item)
    frm.select(:id=>"view").set(list_item)
  end

  # Clicks the Merge link and goes to the AnnouncementsMerge class.
  action(:merge) { |b| b.frm.link(:text=>"Merge").click }

end

# Show Announcements from Another Site. On this page you select what announcements
# you want to merge into the current Site.
class AnnouncementsMerge < BasePage

  frame_element

  # Checks the checkbox for the specified site name
  # @param site_name [String] the name of the relevant site displayed in the table
  def check(site_name)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(site_name)}/).checkbox(:id=>/site/).set
  end

  # Clicks the Save button and goes to the Announcements class.
  action(:save) { |b| b.frm.button(:value=>"Save").click }

end

# This Class does double-duty. It's for the Preview page when editing an
# Announcement, plus for when you just click an Announcement to view it.
class PreviewAnnouncements < BasePage

  frame_element

  # Clicks the Return to list button and goes to the Announcements class.
  action(:return_to_list){ |b| b.frm.button(:value=>"Return to List").click }

  # Clicks the Save changes button and goes to the Announcements class.
  action(:save_changes) { |b| b.frm.button(:value=>"Save Changes").click }

  # Clicks the Edit button and goes to the AddEditAnnouncements class.
  action(:edit) { |b| b.frm.button(:value=>"Edit").click }

end

# The page where an announcement is created or edited.
class AddEditAnnouncements < BasePage

  include FCKEditor
  frame_element

  expected_element editor

  element(:editor) { |b| b.frm.frame(:id, "body___Frame") }

  # Clicks the Add Announcement button. The next class is either
  # AddEditAnnouncements or Announcements.
  action(:add_announcement) { |b| b.frm.button(:value=>"Add Announcement").click }

  # Clicks the Save changes button. Next is the Announcements class.
  action(:save_changes) { |b| b.frm.button(:value=>"Save Changes").click }

  # Clicks the Preview button. Next is the PreviewAnnouncements class.
  action(:preview){ |b| b.frm.button(:value=>"Preview").click }


  # Sends the specified text block to the rich text editor
  # @param text [String] the text that you want to add to the editor.
  def body=(text)
    frm.frame(:id, "body___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # Clicks the Add attachments button and returns the Announcments Attach class.
  def add_attachments
    frm.button(:value=>"Add Attachments").click
    AnnouncementsAttach.new(@browser)
  end

  # Clicks the checkbox for the specified group name
  # when you've set the announcement access to display
  # to groups.
  # @param group_name [String] the name of the group in the table that you intend to select.
  def check_group(group_name)
    frm.table(:id=>"groupTable").row(:text=>/#{Regexp.escape(group_name)}/).checkbox(:name=>"selectedGroups").set
  end

  # Sets the Announcement Title field to the specified
  # string value.
  # @param string [String] the text you want to put in the title field.
  def title=(string)
    frm.text_field(:id=>"subject").set(string)
  end

  # Clicks the radio button for "Only members of this site can see this announcement"
  def select_site_members
    frm.radio(:id=>"site").set
  end

  # Clicks the radio button for "This announcement is publicly viewable"
  def select_publicly_viewable
    frm.radio(:id=>"pubview").set
  end

  # Clicks the radio button for "Displays this announcement to selected groups only."
  def select_groups
    frm.radio(:id=>"groups").set
  end

  # Clicks the radio button for "Show - (Post and display this announcement immediately)"
  def select_show
    frm.radio(:id=>"hidden_false").set
  end

  # Clicks the radio button for "Hide - (Draft mode - Do not display this announcement at this time)"
  def select_hide
    frm.radio(:id=>"hidden_true").set
  end

  # Clicks the radio button for "Specify Dates - (Choose when this announcement will be displayed)"
  def select_specify_dates
    frm.radio(:id=>"hidden_specify").set
  end

  # Checks the checkbox for "Beginning"
  def check_beginning
    frm.checkbox(:id=>"use_start_date").set
  end

  # Checks the checkbox for "Ending"
  def check_ending
    frm.checkbox(:id=>"use_end_date").set
  end

  # Checks the checkbox for selecting all Groups
  def check_all
    frm.checkbox(:id=>"selectall").set
  end

  # Sets the Beginning Month selection to the
  # specified string.
  def beginning_month=(string)
    frm.select(:id=>"release_month").select(string)
  end

  # Sets the Beginning Day selection to the
  # specified string.
  def beginning_day=(string)
    frm.select(:id=>"release_day").select(string)
  end

  # Sets the Beginning Year selection to the
  # specified string.
  def beginning_year=(string)
    frm.select(:id=>"release_year").select(string)
  end

  # Sets the Beginning Hour selection to the
  # specified string
  def beginning_hour=(string)
    frm.select(:id=>"release_hour").select(string)
  end

  # Sets the Beginning Minute selection to the
  # specified string
  def beginning_minute=(string)
    frm.select(:id=>"release_minute").select(string)
  end

  # Sets the AM or PM value to the specified string.
  # Obviously the string should be either "AM" or "PM".
  def beginning_meridian=(string)
    frm.select(:id=>"release_ampm").select(string)
  end

  # Sets the Ending Month selection to the specified
  # string.
  def ending_month=(string)
    frm.select(:id=>"retract_month").select(string)
  end

  # Sets the Ending Day selection to the specified
  # string.
  def ending_day=(string)
    frm.select(:id=>"retract_day").select(string)
  end

  # Sets the Ending Year selection to the specified
  # string.
  def ending_year=(string)
    frm.select(:id=>"retract_year").select(string)
  end

  # Sets the Ending Hour selection to the specified
  # string.
  def ending_hour=(string)
    frm.select(:id=>"retract_hour").select(string)
  end

  # Sets the Ending Minute selection to the specified
  # string.
  def ending_minute=(string)
    frm.select(:id=>"retract_minute").select(string)
  end

  # Sets the Ending AM/PM selection to the specified
  # value.
  def ending_meridian=(string)
    frm.select(:id=>"retract_ampm").select(string)
  end

  # Gets the text of the alert message when it appears on
  # the page
  def alert_message
    frm.div(:class=>"alertMessage").text
  end

end

# Page for merging announcements from other sites
class AnnouncementsMerge < BasePage

  frame_element

end

# Page for setting up options for announcements
class AnnouncementsOptions < BasePage

  frame_element

end

# Page containing permissions options for announcements
class AnnouncementsPermissions < BasePage

  frame_element

end