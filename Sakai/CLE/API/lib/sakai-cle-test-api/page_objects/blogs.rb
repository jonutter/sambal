class BlogsBase < BasePage

  frame_element

  class << self
    def menu_elements
      # AddBlogEntry
      action(:add_blog_entry) { |b| b.frm.link(:text=>"Add blog entry").click }
    end
  end
end

class Blogs < BlogsBase

  menu_elements

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

class AddBlogEntry < BlogsBase

  menu_elements

  include FCKEditor

  expected_element :editor

  element(:editor) { |b| b.frm.frame(:id, "blog-text-input:1:input___Frame") }

  def blog_text=(text)
    editor.td(:id, "xEditingArea").frame(:index=>0).wait_until_present
    editor.td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # BlogsList
  action(:publish_entry) { |b| b.frm.button(:value=>"Publish entry").click }
  # BlogsList
  action(:save_draft){ |b| b.frm.button(:value=>"Save Draft").click }

  element(:title) { |b| b.frm.text_field(:name=>"title-input") }
  element(:only_site_admins) { |b| b.frm.radio(:id=>"instructors-only-radio") }
  element(:all_members) { |b| b.frm.radio(:id=>"all-members-radio") }
  element(:publicly_viewable) { |b| b.frm.radio(:id=>"public-viewable-radio") }

end

class BlogsList < BlogsBase

  menu_elements

end