#================
# Syllabus pages in a Site
#================

# The topmost page in the Syllabus feature.
# If there are no syllabus items it will appear
# differently than if there are.
class Syllabus < BasePage

  frame_element

  # Clicks the "Create/Edit" button on the page,
  # then instantiates the SyllabusEdit class.
  def create_edit
    frm.link(:text=>"Create/Edit").click
    SyllabusEdit.new(@browser)
  end

  # Clicks the "Add" button, then
  # instantiates the AddEditSyllabusItem Class.
  def add
    frm.link(:text=>"Add").click
    AddEditSyllabusItem.new(@browser)
  end

  def attachments_list
    list = []
    frm.div(:class=>"portletBody").links.each { |link| list << link.text }
    return list
  end

end

# This is the page that lists Syllabus sections, allows for
# moving them up or down in the list, and allows for removing
# items from the syllabus.
class SyllabusEdit < BasePage

  frame_element

  # Clicks the "Add" button, then
  # instantiates the AddEditSyllabusItem Class.
  def add
    frm.link(:text=>"Add").click
    AddEditSyllabusItem.new(@browser)
  end

  def redirect
    frm.link(:text=>"Redirect").click
    SyllabusRedirect.new(@browser)
  end

  # Returns the text of the page header
  def header
    frm.div(:class=>"portletBody").h3.text
  end

  # Clicks the checkbox for the item with the
  # specified title.
  def check_title(title)
    index=syllabus_titles.index(title)
    frm.checkbox(:index=>index).set
  end

  #
  def move_title_up(title)
    #FIXME
  end

  #
  def move_title_down(title)
    #FIXME
  end

  # Clicks the "Update" button and instantiates
  # the DeleteSyllabusItems Class.
  def update
    frm.button(:value=>"Update").click
    DeleteSyllabusItems.new(@browser)
  end

  # Opens the specified item and instantiates the XXXX Class.
  def open_item(title)
    frm.link(:text=>title).click
    Class.new(@browser)
  end

  # Returns an array containing the titles of the syllabus items
  # displayed on the page.
  def syllabus_titles
    titles = []
    s_table = frm.table(:class=>"listHier lines nolines")
    1.upto(s_table.rows.size-1) do |x|
      titles << s_table[x][0].text
    end
    return titles
  end

end

#
class AddEditSyllabusItem < BasePage

  frame_element
  include FCKEditor

  expected_element editor

  # Clicks the "Post" button and instantiates
  # the Syllabus Class.
  def post
    frm.button(:value=>"Post").click
    SyllabusEdit.new(@browser)
  end

  # Defines the text area of the FCKEditor that appears on the page for
  # the Syllabus content.
  def editor
    frm.frame(:id, /_textarea___Frame/).td(:id, "xEditingArea").frame(:index=>0)
  end

  # Sends the specified string to the FCKEditor text area on the page.
  def content=(text)
    editor.send_keys(text)
  end

  # Clicks the Add attachments button and instantiates the
  # SyllabusAttach class.
  def add_attachments
    frm.button(:value=>"Add attachments").click
    SyllabusAttach.new(@browser)
  end

  # Returns an array of the filenames in the attachments
  # table
  def files_list
    names = []
    frm.table(:class=>"listHier lines nolines").rows.each do |row|
      if row.td(:class=>"item").exist?
        names << row.td(:class=>"item").h4.text
      end
    end
    return names
  end

  # Clicks the preview button and
  # instantiates the SyllabusPreview class
  def preview
    frm.button(:value=>"Preview").click
    SyllabusPreview.new(@browser)
  end

  element(:title)  { |b| b.frm.text_field(:id=>"_id4:title") }
  element(:only_members_of_this_site) { |b| b.frm.radio_button(:name=>/_id\d+:_id\d+/, :value=>"no") }
  element(:publicly_viewable) { |b| b.frm.radio_button(:name=>/_id\d+:_id\d+/, :value=>"yes") }

end

# The page for previewing a syllabus.
class SyllabusPreview < BasePage

  frame_element

  action(:edit) { |b| b.frm.button(:value=>"Edit").click }

end

#
class SyllabusRedirect < BasePage

  frame_element

  action(:save) { |b| b.frm.button(:value=>"Save").click }
  element(:url) { |b| b.frm.text_field(:id=>"redirectForm:urlValue") }

end

# The page where Syllabus Items can be deleted.
class DeleteSyllabusItems < BasePage

  frame_element

  action(:delete) { |b| b.frm.button(:value=>"Delete").click }

end

class CreateEditSyllabus < BasePage

  frame_element

end