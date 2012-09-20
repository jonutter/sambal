#================
# Styles pages in a Portfolio Site
#================

# 
class Styles < BasePage

  frame_element
  
  # Clicks the Add link and
  # instantiates the AddStyle Class.
  def add
    frm.link(:text=>"Add").click
    AddStyle.new(@browser)
  end

end

# 
class AddStyle < BasePage

  frame_element
  
  # Clicks the Add Style button and
  # instantiates the Styles Class.
  def add_style
    frm.button(:value=>"Add Style").click
    Styles.new(@browser)
  end
  
  # Clicks the "Select File" link and
  # instantiates the StylesAddAttachment Class.
  def select_file
    frm.link(:text=>"Select File").click
    StylesAddAttachment.new(@browser)
  end

  element(:name) { |b| b.frm.text_field(:id=>"name-id") }
  element(:description) { |b| b.frm.text_field(:id=>"descriptionTextArea") }

end

# TODO Dry this up because there can be a superclass here
class StylesUploadFiles < ResourcesBase
  
  @@filex=0
  
  # Note that the file_to_upload method can be used
  # multiple times, but it assumes
  # that the add_another_file method is used
  # before it, every time except before the first time.
  def file_to_upload(file_name, file_path="")
    frm.file_field(:id, "content_#{@@filex}").set(file_path + file_name)
    @@filex+=1
  end
  
  # Clicks the "Upload Files Now" button
  # then instantiates the StylesAddAttachment Class.
  def upload_files_now
    frm.button(:value=>"Upload Files Now").click
    sleep 0.5
    @@filex=0
    StylesAddAttachment.new(@browser)
  end
  
  # Clicks the "Add Another File" link.
  def add_another_file
    frm.link(:text=>"Add Another File").click
  end
  
end



