class Forums < BasePage

  frame_element

  # Pass this method a string that matches
  # the title of a Forum on the page, it returns
  # True if the specified forum row has "DRAFT" in it.
  def draft?(title)
    frm.table(:id=>"msgForum:forums").row(:text=>/#{Regexp.escape(title)}/).span(:text=>"DRAFT").exist?
  end

  def new_forum
    frm.link(:text=>"New Forum").click
    EditForum.new(@browser)
  end

  def new_topic_for_forum(name)
    index = forum_titles.index(name)
    frm.link(:text=>"New Topic", :index=>index).click
    AddEditTopic.new(@browser)
  end

  def organize
    frm.link(:text=>"Organize").click
    OrganizeForums.new(@browser)
  end

  def template_settings
    frm.link(:text=>"Template Settings").click
    ForumTemplateSettings.new(@browser)
  end

  def forums_table
    frm.div(:class=>"portletBody").table(:id=>"msgForum:forums")
  end

  def forum_titles
    titles = []
    title_links = frm.div(:class=>"portletBody").links.find_all { |link| link.class_name=="title" && link.id=="" }
    title_links.each { |link| titles << link.text }
    return titles
  end

  def topic_titles
    titles = []
    title_links = frm.div(:class=>"portletBody").links.find_all { |link| link.class_name == "title" && link.id != "" }
    title_links.each { |link| titles << link.text }
    return titles
  end

  def forum_settings(name)
    index = forum_titles.index(name)
    frm.link(:text=>"Forum Settings", :index=>index).click
    EditForum.new(@browser)
  end

  def topic_settings(name)
    index = topic_titles.index(name)
    frm.link(:text=>"Topic Settings", :index=>index).click
    AddEditTopic.new(@browser)
  end

  def delete_forum(name)
    index = forum_titles.index(name)
    frm.link(:id=>/msgForum:forums:\d+:delete/,:text=>"Delete", :index=>index).click
    EditForum.new(@browser)
  end

  def delete_topic(name)
    index = topic_titles.index(name)
    frm.link(:id=>/topics:\d+:delete_confirm/, :text=>"Delete", :index=>index).click
    AddEditTopic.new(@browser)
  end

  def open_forum(forum_title)
    frm.link(:text=>forum_title).click
    # New Class def goes here.
  end

  def open_topic(topic_title)
    frm.link(:text=>topic_title).click
    TopicPage.new(@browser)
  end
end

class TopicPage < BasePage

  frame_element

  def post_new_thread
    frm.link(:text=>"Post New Thread").click
    ComposeForumMessage.new(@browser)
  end

  def thread_titles
    titles = []
    message_table = frm.table(:id=>"msgForum:messagesInHierDataTable")
    1.upto(message_table.rows.size-1) do |x|
      titles << message_table[x][1].span(:class=>"firstChild").link(:index=>0).text
    end
    return titles
  end

  def open_message(message_title)
    frm.div(:class=>"portletBody").link(:text=>message_title).click
    ViewForumThread.new(@browser)
  end

  def display_entire_message
    frm.link(:text=>"Display Entire Message").click
    TopicPage.new(@browser)
  end
end

class ViewForumThread < BasePage

  frame_element

  def reply_to_thread
    frm.link(:text=>"Reply to Thread").click
    ComposeForumMessage.new(@browser)
  end

  def reply_to_message(index)
    frm.link(:text=>"Reply", :index=>(index.to_i - 1)).click
    ComposeForumMessage.new(@browser)
  end
end

class ComposeForumMessage < BasePage

  include FCKEditor
  frame_element

  expected_element editor

  def post_message
    frm.button(:text=>"Post Message").click
    # Not sure if we need logic here...
    TopicPage.new(@browser)
  end

  element(:editor) { |b| b.frm.frame(:id, "dfCompose:df_compose_body_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0) }

  def message=(text)
    editor.send_keys(text)
  end

  def reply_text
    @browser.frame(:index=>1).div(:class=>"singleMessageReply").text
  end

  def add_attachments
    #FIXME
  end

  def cancel
    frm.button(:value=>"Cancel").click
    # Logic for picking the correct page class
    if frm.link(:text=>"Reply to Thread")
      ViewForumThread.new(@browser)
    elsif frm.link(:text=>"Post New Thread").click
      TopicPage.new(@browser)
    end
  end

  element(:title) { |b| b.frm.text_field(:id=>"dfCompose:df_compose_title") }

end

class ForumTemplateSettings < BasePage

  frame_element

  value(:page_title) { |b| b.frm.div(:class=>"portletBody").h3(:index=>0).text }

  def save
    frm.button(:value=>"Save").click
    Forums.new(@browser)
  end

  def cancel
    frm.button(:value=>"Cancel").click
    Forums.new(@browser)
  end

end

class OrganizeForums < BasePage

  frame_element

  def save
    frm.button(:value=>"Save").click
    Forums.new(@browser)
  end

  # These are set to so that the user
  # does not have to start the list at zero...
  def forum(index)
    frm.select(:id, "revise:forums:#{index.to_i - 1}:forumIndex")
  end

  def topic(forumindex, topicindex)
    frm.select(:id, "revise:forums:#{forumindex.to_i - 1}:topics:#{topicindex.to_i - 1}:topicIndex")
  end
end

class EditForum < BasePage

  frame_element

  def save
    frm.button(:value=>"Save").click
    Forums.new(@browser)
  end

  def save_and_add
    frm.button(:value=>"Save Settings & Add Topic").click
    AddEditTopic.new(@browser)
  end

  def editor
    frm.div(:class=>"portletBody").frame(:id, "revise:df_compose_description_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0)
  end

  def description=(text)
    editor.send_keys(text)
  end

  def add_attachments
    frm.button(:value=>/attachments/).click
    ForumsAddAttachments.new(@browser)
  end

  element(:title){ |b| b.frm.text_field(:id=>"revise:forum_title") }
  element(:short_description){ |b| b.frm.text_field(:id=>"revise:forum_shortDescription") }

end

class AddEditTopic < BasePage

  frame_element

  @@table_index=0

  def editor
    frm.div(:class=>"portletBody").frame(:id, "revise:topic_description_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0)
  end

  def description=(text)
    editor.send_keys(text)
  end

  def save
    frm.button(:value=>"Save").click
    Forums.new(@browser)
  end

  def add_attachments
    frm.button(:value=>/Add.+ttachment/).click
    ForumsAddAttachments.new(@browser)
  end

  def roles
    roles=[]
    options = frm.select(:id=>"revise:role").options.to_a
    options.each { |option| roles << option.text }
    return roles
  end

  def site_role=(role)
    frm.select(:id=>"revise:role").select(role)
    0.upto(frm.select(:id=>"revise:role").length - 1) do |x|
      if frm.div(:class=>"portletBody").table(:class=>"permissionPanel jsfFormTable lines nolines", :index=>x).visible?
        @@table_index = x

        def permission_level=(value)
          frm.select(:id=>"revise:perm:#{@@table_index}:level").select(value)
        end

      end
    end
  end

  element(:title) { |b| b.frm.text_field(:id=>"revise:topic_title") }
  element(:short_description) { |b| b.frm.text_field(:id=>"revise:topic_shortDescription") }

end