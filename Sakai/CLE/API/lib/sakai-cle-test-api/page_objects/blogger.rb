#================
# Blogger Pages
#================

# The top page of a Site's Blogger feature.
class Blogger < BasePage

  frame_element

  # Clicks the View All button, then reinstantiates the Class.
  def view_all
    frm.link(:text=>"View all").click
    Blogger.new(@browser)
  end

  # Clicks the View Members Blog link, then instantiates the
  # ViewMembersBlog Class.
  def view_members_blog
    frm.link(:text=>"View member's blog").click
    ViewMembersBlog.new(@browser)
  end

  # Returns true if the specified post title exists in the list. Otherwise returns false.
  def post_private?(post_title)
    frm.table(:class=>"tableHeader").row(:text=>/#{Regexp.escape(post_title)}/).image(:alt=>"p").exist?
  end

  # Clicks the Create New Post link and instantiates the CreateBloggerPost Class.
  def create_new_post
    frm.link(:text=>"Create new post").click
    CreateBloggerPost.new(@browser)
  end
  # Clicks on the specified post title, then instantiates
  # the ViewBloggerPost Class.
  def open_post(post_title)
    frm.link(:text=>post_title).click
    ViewBloggerPost.new(@browser)
  end

  # Returns an array containing the displayed post titles (as string objects).
  def post_titles
    titles = []
    if frm.table(:class=>"tableHeader").exist?
      table = frm.table(:class=>"tableHeader")
      table.rows.each do |row|
        if row.link(:class=>"aTitleHeader").exist?
          titles << row.link(:class=>"aTitleHeader").text
        end
      end
    end
    return titles
  end

  element(:search_field) { |b| b.frm.text_field(:id=>"_id1:idSearch") }
  element(:show_comments) { |b| b.frm.checkbox(:id=>"_id1:showComments") }
  element(:show_full_content) { |b| b.frm.checkbox(:id=>"_id1:showFullContent") }

end

# The page showing contents of a user's Blog.
class ViewMembersBlog < BasePage

  frame_element

  # Clicks on the member name specified.
  # The name string obviously needs to match the
  # text of the link exactly.
  def member(name)
    frm.link(:text=>name).click
    Blogger.new(@browser)
  end

end

# The page where users create a Post for their Blogger blog.
class CreateBloggerPost < BasePage

  frame_element

  # Enters the specified string into the FCKEditor for the Abstract.
  def abstract=(text)
    frm.frame(:id, "PostForm:shortTextBox_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # Enters the specified string into the FCKEditor for the Text of the Blog.
  def text=(text)
    frm().frame(:id, "PostForm:tab0:main_text_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  # Clicks the Add to document button in the text
  # tab.
  def add_text_to_document
    frm.div(:id=>"PostForm:tab0").button(:value=>"Add to document").click
  end

  # Clicks the Add to Document button on the Image tab.
  #
  # This method will fail if the image tab is not the currently selected tab.
  def add_image_to_document
    frm.div(:id=>"PostForm:tab1").button(:value=>"Add to document").click
  end

  # Clicks the Add to Document button on the Link tab.
  #
  # This method will fail if the Link tab is not the currently selected tab.
  def add_link_to_document
    frm.div(:id=>"PostForm:tab2").button(:value=>"Add to document").click
  end

  # Clicks the Add to Document button on the File tab.
  #
  # This method will fail if the File tab is not the currently selected tab.
  def add_file_to_document
    frm.div(:id=>"PostForm:tab3").button(:value=>"Add to document").click
  end

  # Enters the specified filename in the file field for images.
  #
  # The file path can be entered as an optional second parameter.
  def image_file(filename, filepath="")
    frm.file_field(:name=>"PostForm:tab1:_id29").set(filepath + filename)
  end

  # Enters the specified directory/filename in the file field.
  def file_field(filename, filepath="")
    frm().file_field(:name=>"PostForm:tab3:_id51").set(filepath + filename)
  end

  # Clicks the Preview button and instantiates the PreviewBloggerPost Class.
  def preview
    frm().button(:value=>"Preview").click
    PreviewBloggerPost.new(@browser)
  end

  # Clicks the Save button and instantiates the Blogger Class.
  def save
    frm.button(:value=>"Save").click
    Blogger.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"PostForm:idTitle") }
  element(:keywords) { |b| b.frm.text_field(:id=>"PostForm:keyWords") }
  element(:access) { |b| b.frm.select(:id=>"PostForm:selectVisibility") }
  element(:read_only) { |b| b.frm.checkbox(:id=>"PostForm:readOnlyCheckBox") }
  element(:allow_comments) { |b| b.frm.checkbox(:id=>"PostForm:allowCommentsCheckBox") }
  action(:text) { |b| b.frm.button(:value=>"Text").click }
  action(:images) { |b| b.frm.button(:value=>"Images").click }
  action(:links) { |b| b.frm.button(:value=>"Links").click }
  element(:description) { |b| b.frm.text_field(:id=>"PostForm:tab2:idLinkDescription") }
  element(:url) { |b| b.frm.text_field(:id=>"PostForm:tab2:idLinkExpression") }
  action(:files) { |b| b.frm.button(:value=>"Files").click }

end

# The Preview page for a Blog post.
class PreviewBloggerPost < BasePage

  frame_element

  # Clicks the Back button and instantiates the CreateBloggerPost Class.
  def back
    frm().button(:value=>"Back").click
    CreateBloggerPost.new(@browser)
  end

  # Clicks the Save button and instantiates the CreateBloggerPost Class.
  def save
    frm.button(:value=>"Save").click
    CreateBloggerPost.new(@browser)
  end

end

# The page for Viewing a blog post.
class ViewBloggerPost < BasePage

  frame_element

  # Clicks the button for adding a comment to a blog post, then
  # instantiates the AddBloggerComment Class.
  def add_comment
    frm.button(:value=>"Add comment").click
    AddBloggerComment.new(@browser)
  end

end

# The page for adding a comment to a Blog post.
class AddBloggerComment < BasePage

  frame_element

  # Clicks the Save button and instantiates
  # The ViewBloggerPost Class.
  def save
    frm.button(:value=>"Save").click
    ViewBloggerPost.new(@browser)
  end

  # Enters the specified string into the FCKEditor box for the Comment.
  def your_comment=(text)
    frm.frame(:id, "_id1:_id11_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

end