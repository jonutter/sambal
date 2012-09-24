#================
# Forms Pages - Portfolio Site
#================

# The topmost page of Forms in a Portfolio Site.
class Forms < BasePage

  frame_element

  # Clicks the Add button and instantiates
  # the AddForm Class.
  def add
    frm.link(:text=>"Add").click
    AddForm.new(@browser)
  end

  # Clicks the Publish buton for the specified
  # Form, then instantiates the PublishForm Class.
  def publish(form_name)
    frm.table(:class=>"listHier lines nolines").tr(:text, /#{Regexp.escape(form_name)}/).link(:text=>/Publish/).click
    PublishForm.new(@browser)
  end

  # Clicks the Import button, then
  # instantiates the ImportForms Class.
  def import
    frm.link(:text=>"Import").click
    ImportForms.new(@browser)
  end

end

class ImportForms < BasePage

  frame_element

  def import
    frm.button(:value=>"Import").click
    Forms.new(@browser)
  end

  def select_file
    frm.link(:text=>"Select File...").click
    AttachFileFormImport.new(@browser)
  end

end

class AddForm < BasePage

  frame_element

  def select_schema_file
    frm.link(:text=>"Select Schema File").click
    SelectSchemaFile.new(@browser)
  end

  def instruction=(text)
    frm.frame(:id, "instruction___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  def add_form
    frm.button(:value=>"Add Form").click
    Forms.new(@browser)
  end

  element(:name) { |b| b.frm.text_field(:id=>"description-id") }


end

class SelectSchemaFile < BasePage

  frame_element

  def show_other_sites
    frm.link(:title=>"Show other sites").click
    SelectSchemaFile.new(@browser)
  end

  def open_folder(name)
    frm.link(:text=>name).click
    SelectSchemaFile.new(@browser)
  end

  def select_file(filename)
    index = file_names.index(filename)
    frm.table(:class=>"listHier lines").tr(:text, /#{Regexp.escape(filename)}/).link(:text=>"Select").click
    SelectSchemaFile.new(@browser)
  end

  def file_names #FIXME
    names = []
    resources_table = frm.table(:class=>"listHier lines")
    1.upto(resources_table.rows.size-1) do |x|
      if resources_table[x][0].link.exist? && resources_table[x][0].a(:index=>0).title=~/File Type/
        names << resources_table[x][0].text
      end
    end
    return names
  end

  def continue
    frm.button(:value=>"Continue").click
    frm.frame(:id, "instruction___Frame").td(:id, "xEditingArea").wait_until_present
    AddForm.new(@browser)
  end

end

class PublishForm < BasePage

  frame_element

  def yes
    frm.button(:value=>"Yes").click
    Forms.new(@browser)
  end

end