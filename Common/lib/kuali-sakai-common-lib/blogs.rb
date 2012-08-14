#================
# Blog Pages - NOT "Blogger"
#================

#
module BlogsMethods
  include PageObject
  # Returns an array containing the list of Bloggers
  # in the "All the blogs" table.
  def blogger_list
    bloggers = []
    frm.table(:class=>"listHier lines").rows.each do |row|
      bloggers << row[1].text
    end
    bloggers.delete_at(0)
    return bloggers
  end

end

module BlogsMenuButtons
  include PageObject

  def add_blog_entry
    frm.link(:text=>"Add blog entry").click
    AddBlogEntry.new @browser
  end

end

module AddBlogEntryMethods
  include PageObject

  def blog_text=(text)
    frm.frame(:id, "blog-text-input:1:input___Frame").td(:id, "xEditingArea").frame(:index=>0).wait_until_present
    frm.frame(:id, "blog-text-input:1:input___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  def publish_entry
    frm.button(:value=>"Publish entry").click
    BlogsList.new @browser
  end

  def save_draft
    frm.button(:value=>"Save Draft").click
    BlogsList.new @browser
  end

  in_frame(:class=>"PortletMainIframe") do |frame|
    text_field(:title, :name=>"title-input", :frame=>frame)
    radio_button(:only_site_admins, :id=>"instructors-only-radio", :frame=>frame)
    radio_button(:all_members, :id=>"all-members-radio", :frame=>frame)
    radio_button(:publicly_viewable, :id=>"public-viewable-radio", :frame=>frame)
  end
end

module BlogsListMethods
  include PageObject

end