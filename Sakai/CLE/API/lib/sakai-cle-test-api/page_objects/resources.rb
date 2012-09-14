#================
# Resources Pages
#================

# Resources page for a given Site, in the Course Tools menu
class Resources < AddFiles

  frame_element

end

# New class template. For quick class creation...
class ResourcesUploadFiles < BasePage

  frame_element

  @@filex=0 # TODO: This is almost certainly not going to work right.

  # Enters the specified folder/filename value into
  # the file field on the page. Note that files are
  # assumed to be in the relative path ../../data/sakai-cle-test-api
  # The method will throw an error if the specified file
  # is not found.
  #
  # This method is designed to be able to use
  # multiple times, but it assumes
  # that the add_another_file method is used
  # before it, every time except before the first time.
  def file_to_upload(file_name, file_path="")
    frm.file_field(:id, "content_#{@@filex}").set(file_path + file_name)
    @@filex+=1
  end

  # Clicks the Upload Files Now button, resets the
  # @@filex class variable back to zero, and instantiates
  # the Resources page class.
  def upload_files_now
    frm.button(:value=>"Upload Files Now").click
    @@filex=0
    Resources.new(@browser)
  end

  # Clicks the Add Another File link.
  def add_another_file
    frm.link(:text=>"Add Another File").click
  end

end

class EditFileDetails < BasePage

  frame_element

  # Clicks the Update button, then instantiates
  # the Resources page class.
  def update
    frm.button(:value=>"Update").click
    Resources.new(@browser)
  end

  # Enters the specified string into the title field.
  def title=(title)
    frm.text_field(:id=>"displayName_0").set(title)
  end

  # Enters the specified string into the description field.
  def description=(description)
    frm.text_field(:id=>"description_0").set(description)
  end

  # Sets the radio button for publically viewable.
  def select_publicly_viewable
    frm.radio(:id=>"access_mode_public_0").set
  end

  # Checks the checkbox for showing only on the specifed
  # condition.
  def check_show_only_if_condition
    frm.checkbox(:id=>"cbCondition_0")
  end

  # Selects the specified Gradebook item value in the
  # select list.
  def gradebook_item=(item)
    frm.select(:id=>"selectResource_0").select(item)
  end

  # Selects the specified value in the item condition
  # field.
  def item_condition=(condition)
    frm.select(:id=>"selectCondition_0").select(condition)
  end

  # Sets the Grade field to the specified value.
  def assignment_grade=(grade)
    frm.text_field(:id=>"assignment_grade_0").set(grade)
  end
end

class CreateFolders < BasePage

  frame_element

  thing(:folder_name) { |b| b.frm.text_field(:id=>"content_0") }
  action(:create_folders_now) { |b| b.frm.button(:value=>"Create Folders Now").click }

end

class CreateHTMLPageContent < BasePage

  frame_element
  include FCKEditor

  thing(:editor) { |b| b.frm.frame(:id=>"content___Frame") }
  action(:continue) { |b| b.frm.button(id: "saveChanges").click }

  def source=(text)
    editor.td(:id, "xEditingArea").text_field(:class=>"SourceField").set text
  end

end

class CreateHTMLPageProperties < BasePage

  frame_element

  thing(:name) { |b| b.frm.text_field(id: "displayName_0") }
  thing(:description) { |b| b.frm.text_field(id: "description_0") }

  action(:finish) { |b| b.frm.button(id: "finish_button").click }

end