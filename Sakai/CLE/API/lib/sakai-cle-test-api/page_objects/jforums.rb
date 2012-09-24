#================
# Discussion Forums Pages
#================

# This module includes page objects that are common to
# all pages in the JForums.
module JForumsResources

  # Clicks the Discussion Home link, then
  # instantiates the JForums page class.
  def discussion_home
    frm.link(:id=>"backtosite").click
    JForums.new(@browser)
  end

  # Clicks the Search button in the Main Menu, then
  # instantiates the DiscussionSearch page class.
  def search
    frm.link(:id=>"search", :class=>"mainmenu").click
    DiscussionSearch.new(@browser)
  end

  # Clicks the My Bookmarks link in the Main Menu,
  # then instantiates the MyBookmarks page class.
  def my_bookmarks
    frm.link(:class=>"mainmenu", :text=>"My Bookmarks").click
    MyBookmarks.new(@browser)
  end

  # Clicks the My Profile link in the Main Menu, then
  # instantiates the DiscussionsMyProfile page class.
  def my_profile
    frm.link(:id=>"myprofile").click
    DiscussionsMyProfile.new(@browser)
  end

  # Clicks the Member Listing link in the Main Menu, then
  # instantiates the DiscussionMemberListing page class.
  def member_listing
    frm.link(:text=>"Member Listing", :id=>"latest", :class=>"mainmenu").click
    DiscussionMemberListing.new(@browser)
  end

  # Clicks the Private Messages link in the Main Menu, then
  # instantiates the PrivateMessages page class.
  def private_messages
    frm.link(:id=>"privatemessages", :class=>"mainmenu").click
    PrivateMessages.new(@browser)
  end

  # Clicks the Manage link on the Main Menu, then
  # instantiates the ManageDiscussions page class.
  def manage
    frm.link(:id=>"adminpanel", :text=>"Manage").click
    ManageDiscussions.new(@browser)
  end

end

# The topmost page in Discussion Forums
class JForums < BasePage

  frame_element
  include JForumsResources

  # Clicks on the supplied forum name
  # Then instantiates the DiscussionForum class.
  def open_forum(forum_name)
    frm.link(:text=>forum_name).click
    DiscussionForum.new(@browser)
  end

  # Clicks the specified Topic and instantiates
  # the ViewTopic Class.
  def open_topic(topic_title)
    frm.link(:text=>topic_title).click
    ViewTopic.new(@browser)
  end

  # Returns an array containing the names of the Forums listed on the page.
  def forum_list
    list = frm.table(:class=>"forumline").links.map do |link|
      if link.href =~ /forums\/show\//
        link.text
      end
    end
    list.compact!
    return list
  end

  # Returns the displayed count of topics for the specified
  # Forum.
  def topic_count(forum_name)
    frm.table(:class=>"forumline").row(:text=>/#{Regexp.escape(forum_name)}/)[2].text
  end

end

# The page of a particular Discussion Forum, show the list
# of Topics in the forum.
class DiscussionForum < BasePage

  frame_element
  include JForumsResources

  # Clicks the New Topic button,
  # then instantiates the NewTopic class
  def new_topic
    frm.image(:alt=>"New Topic").fire_event("onclick")
    frm.frame(:id, "message___Frame").td(:id, "xEditingArea").wait_until_present
    NewTopic.new(@browser)
  end

  # Clicks the specified Topic Title, then
  # instantiates the ViewTopic Class.
  def open_topic(topic_title)
    frm.link(:href=>/posts.list/, :text=>topic_title).click
    ViewTopic.new(@browser)
  end

end

# The Discussion Forums Search page.
class DiscussionSearch < BasePage

  frame_element

  include JForumsResources

  # Clicks the Search button on the page,
  # then instantiates the JForums class.
  def click_search
    frm.button(:value=>"Search").click
    JForums.new(@browser)
  end


  element(:keywords) { |b| b.frm.text_field(:name=>"search_keywords") }

end

# The Manage Discussions page in Discussion Forums.
class ManageDiscussions < BasePage

  frame_element

  include JForumsResources

  # Clicks the Manage Forums link,
  # then instantiates the ManageForums Class.
  def manage_forums
    frm.link(:text=>"Manage Forums").click
    ManageForums.new(@browser)
  end

  # Creates and returns an array of forum titles
  # which can be used for verification
  def forum_titles
    forum_titles = []
    forum_links = frm.links.find_all { |link| link.id=="forumEdit"}
    forum_links.each { |link| forum_titles << link.text }
    return forum_titles
  end

end

# The page for Managing Forums in the Discussion Forums
# feature.
class ManageForums < BasePage

  frame_element
  include JForumsResources

  # Clicks the Add button, then
  # instantiates the ManageForums Class.
  def add
    frm.button(:value=>"Add").click
    ManageForums.new(@browser)
  end

  # Clicks the Update button, then
  # instantiates the ManageDiscussions Class.
  def update
    frm.button(:value=>"Update").click
    ManageDiscussions.new(@browser)
  end


  element(:forum_name) { |b| b.frm.text_field(:name=>"forum_name") }
  element(:category) { |b| b.frm.select(:id=>"categories_id") }
  element(:description) { |b| b.frm.text_field(:name=>"description") }

end

# Page for editing/creating Bookmarks in Discussion Forums.
class MyBookmarks < BasePage

  frame_element
  include JForumsResources


end

# The page for adding a new discussion topic.
class NewTopic < BasePage

  frame_element
  include JForumsResources

  # Enters the specified string into the FCKEditor for the Message.
  def message_text=(text)
    frm.frame(:id, "message___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(:home)
    frm.frame(:id, "message___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # Clicks the Submit button, then instantiates the ViewTopic Class.
  def submit
    frm.button(:value=>"Submit").click
    ViewTopic.new(@browser)
  end

  # Clicks the Preview button and instantiates the PreviewDiscussionTopic Class.
  def preview
    frm.button(:value=>"Preview").click
    PreviewDiscussionTopic.new(@browser)
  end

  # Enters the specified filename in the file field. The path to the file can be entered as an optional second parameter
  def filename1(filename, filepath="")
    frm.file_field(:name=>"file_0").set(filepath + filename)
  end

  # Enters the specified filename in the file field.
  #
  # Note that the file should be inside the data/sakai-cle-test-api folder.
  # The file or folder name used for the filename variable
  # should not include a preceding / character.
  def filename2(filename)
    frm.file_field(:name=>"file_1").set(File.expand_path(File.dirname(__FILE__)) + "/../../data/sakai-cle-test-api/" + filename)
  end


  element(:subject) { |b| b.frm.text_field(:id=>"subject") }
  action(:attach_files) { |b| b.frm.button(:value=>"Attach Files").click }
  action(:add_another_file) { |b| b.frm.button(:value=>"Add another file").click }

end

# Viewing a Topic/Message
class ViewTopic < BasePage

  frame_element
  include JForumsResources

  # Gets the text of the Topic title.
  # Useful for verification.
  def topic_name
    frm.link(:id=>"top", :class=>"maintitle").text
  end

  # Gets the message text for the specified message (not zero-based).
  # Useful for verification.
  def message_text(message_number)
    frm.span(:class=>"postbody", :index=>message_number.to_i-1).text
  end

  # Clicks the Post Reply button, then
  # instantiates the NewTopic Class.
  def post_reply
    frm.image(:alt=>"Post Reply").fire_event("onclick")
    NewTopic.new(@browser)
  end

  # Clicks the Quick Reply button
  # and does not instantiate any page classes.
  def quick_reply
    frm.image(:alt=>"Quick Reply").fire_event("onclick")
  end

  # Clicks the submit button underneath the Quick Reply box,
  # then re-instantiates the class, due to the page update.
  def submit
    frm.button(:value=>"Submit").click
    ViewTopic.new(@browser)
  end


  element(:reply_text) { |b| b.frm.text_field(:name=>"quickmessage") }


end

# The Profile page for Discussion Forums
class DiscussionsMyProfile < BasePage

  frame_element
  include JForumsResources

  def submit
    frm.button(:value=>"Submit").click
    DiscussionsMyProfile.new(@browser)
  end

  # Gets the text at the top of the table.
  # Useful for verification.
  def header_text
    frm.table(:class=>"forumline").span(:class=>"gens").text
  end

  # Enters the specified filename in the file field.
  #
  # The method takes the filepath as an optional second parameter.
  def avatar(filename, filepath="")
    frm.file_field(:name=>"avatar").set(filepath + filename)
  end

  element(:icq_uin) { |b| b.frm.text_field(:name=>"icq") }
  element(:aim) { |b| b.frm.text_field(:name=>"aim") }
  element(:web_site) { |b| b.frm.text_field(:name=>"website") }
  element(:occupation) { |b| b.frm.text_field(:name=>"occupation") }
  element(:view_email) { |b| b.radio(:name=>"viewemail") }

end

# The List of Members of a Site's Discussion Forums
class DiscussionMemberListing < BasePage

  frame_element
  include JForumsResources

  # Checks if the specified Member name appears
  # in the member listing.
  def name_present?(name)
    member_links = frm.links.find_all { |link| link.href=~/user.profile/ }
    member_names = []
    member_links.each { |link| member_names << link.text }
    member_names.include?(name)
  end

end

# The page where users go to read their private messages in the Discussion
# Forums.
class PrivateMessages < BasePage

  frame_element
  include JForumsResources

  # Clicks the "New PM" button, then
  # instantiates the NewPrivateMessage Class.
  def new_pm
    frm.image(:alt=>"New PM").fire_event("onclick")
    NewPrivateMessage.new(@browser)
  end

  # Clicks to open the specified message,
  # then instantiates the ViewPM Class.
  def open_message(title)
    frm.link(:class=>"topictitle", :text=>title).click
    ViewPM.new(@browser)
  end

  # Collects all subject text strings of the listed
  # private messages and returns them in an Array.
  def pm_subjects
    anchor_objects = frm.links.find_all { |link| link.href=~/pm.read.+page/ }
    subjects = []
    anchor_objects.each { |link| subjects << link.text }
    return subjects
  end

end

# The page of Viewing a particular Private Message.
class ViewPM < BasePage

  frame_element

  # Clicks the Reply Quote button, then
  # instantiates the NewPrivateMessage Class.
  def reply_quote
    frm.image(:alt=>"Reply Quote").fire_event("onclick")
    NewPrivateMessage.new(@browser)
  end

end

# New Private Message page in Discussion Forums.
class NewPrivateMessage < BasePage

  frame_element
  include JForumsResources

  # Enters text into the FCKEditor text area, after
  # going to the beginning of any existing text in the field.
  def message_body=(text)
    frm.frame(:id, "message___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(:home)
    frm.frame(:id, "message___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # Clicks the Submit button, then
  # instantiates the Information Class.
  def submit
    frm.button(:value=>"Submit").click
    Information.new(@browser)
  end

  # Enters the specified filename in the file field.
  def filename1(filename)
    frm.file_field(:name=>"file_0").set(File.expand_path(File.dirname(__FILE__)) + "/../../data/sakai-cle-test-api/" + filename)
  end

  # Enters the specified filename in the file field.
  #
  # Note that the file should be inside the data/sakai-cle-test-api folder.
  # The file or folder name used for the filename variable
  # should not include a preceding / character.
  def filename2(filename)
    frm.file_field(:name=>"file_1").set(File.expand_path(File.dirname(__FILE__)) + "/../../data/sakai-cle-test-api/" + filename)
  end


  element(:to_user) { |b| b.frm.select(:name=>"toUsername") }
  element(:subject) { |b| b.frm.text_field(:id=>"subject") }
  action(:attach_files) { |b| b.frm.button(:value=>"Attach Files").click }
  action(:add_another_file) { |b| b.frm.button(:value=>"Add another file").click }


end

# The page that appears when you've done something in discussions, like
# sent a Private Message.
class Information < BasePage

  frame_element
  include JForumsResources

  # Gets the information message on the page.
  # Useful for verification.
  def information_text
    frm.table(:class=>"forumline").span(:class=>"gen").text
  end

end