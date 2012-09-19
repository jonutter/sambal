#================
# Glossary Pages - for a Portfolio Site
#================

class Glossary < BasePage

  frame_element

  def add
    frm.link(:text=>"Add").click
    frm.frame(:id, "longDescription___Frame").td(:id, "xEditingArea").wait_until_present
    AddEditTerm.new(@browser)
  end

  def import
    frm.link(:text=>"Import").click
    GlossaryImport.new(@browser)
  end

  def edit(term)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(term)}/).link(:text=>"Edit").click
    AddEditTerm.new(@browser)
  end

  def delete(term)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(term)}/).link(:text=>"Delete").click
    AddEditTerm.new(@browser)
  end

  def open(term)
    frm.link(:text=>term).click
    #FIXME!
    # Need to do special handling here because of the new window.
  end

  # Returns an array containing the string values of the terms
  # displayed in the list.
  def terms
    term_list = []
    frm.table(:class=>"listHier lines nolines").rows.each do |row|
      term_list << row[0].text
    end
    term_list.delete_at(0)
    return term_list
  end

end

class AddEditTerm < BasePage

  frame_element

  def add_term
    frm.button(:value=>"Add Term").click
    Glossary.new(@browser)
  end

  def save_changes
    frm.button(:value=>"Save Changes").click
    Glossary.new(@browser)
  end

  def long_description=(text)
    frm.frame(:id, "longDescription___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end


  element(:term) { |b| b.frm.text_field(:id=>"term-id") }
  element(:short_description) { |b| b.frm.text_field(:id=>"description-id") }

end

# Page for importing Glossary files into a Glossary
class GlossaryImport < BasePage

  frame_element

  def select_file
    frm.link(:text=>"Select file...").click
    GlossaryAttach.new(@browser)
  end

  def import
    frm.button(:value=>"Import").click
    Glossary.new(@browser)
  end

end

# The file upload page for Glossary importing
class GlossaryFileUpload < BasePage

  frame_element

  @@filex=0

  # Note that the file_to_upload method can be used
  # multiple times, but it assumes
  # that the add_another_file method is used
  # before it, every time except before the first time.
  def file_to_upload(file_name, file_path="")
    frm.file_field(:id, "content_#{@@filex}").set(file_path + file_name)
    @@filex+=1
  end

  def upload_files_now
    frm.button(:value=>"Upload Files Now").click
    sleep 0.5
    @@filex=0
    GlossaryAttach.new(@browser)
  end

  def add_another_file
    frm.link(:text=>"Add Another File").click
  end

end