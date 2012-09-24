#================
# Portfolio Templates pages
#================

#
class PortfolioTemplates < BasePage

  frame_element

  # Clicks the Add link and instantiates the
  # AddPortfolioTemplate class.
  def add
    frm.link(:text=>"Add").click
    AddPortfolioTemplate.new(@browser)
  end

  # Clicks the "Publish" link for the specified Template.
  def publish(templatename)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(templatename)}/).link(:text=>"Publish").click
  end

  # Clicks the "Edit" link for the specified Template.
  def edit(templatename)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(templatename)}/).link(:text=>"Edit").click
  end

  # Clicks the "Delete" link for the specified Template.
  def delete(templatename)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(templatename)}/).link(:text=>"Delete").click
  end

  # Clicks the "Copy" link for the specified Template.
  def copy(templatename)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(templatename)}/).link(:text=>"Copy").click
  end

  # Clicks the "Export" link for the specified Template.
  def export(templatename)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(templatename)}/).link(:text=>"Export").click
  end

end

#
class AddPortfolioTemplate < BasePage

  frame_element

  # Clicks the Continue button and instantiates the BuildTemplate Class.
  def continue
    frm.button(:value=>"Continue").click
    BuildTemplate.new(@browser)
  end

  element(:name) { |b| b.frm.text_field(:id=>"name-id") }
  element(:description) { |b| b.frm.text_field(:id=>"description") }


end

#
class BuildTemplate < BasePage

  frame_element

  # Clicks the Select File link and instantiates the
  # PortfolioAttachFiles Class.
  def select_file
    frm.link(:text=>"Select File").click
    PortfolioAttachFiles.new(@browser)
  end

  # Clicks the Continue button and instantiates
  # PortfolioContent Class.
  def continue
    frm.button(:value=>"Continue").click
    PortfolioContent.new(@browser)
  end

  element(:outline_options_form_type) { |b| b.frm.select(:id=>"propertyFormType-id") }

end

#
class PortfoliosUploadFiles < BasePage # TODO - This class is not DRY. Identical methods in multiple classes

  frame_element

  @@filex=0

  # Note that the file_to_upload method can be used
  # multiple times, but it assumes
  # that the add_another_file method is used
  # before it, every time except before the first time.
  def file_to_upload(file_name, file_path)
    frm.file_field(:id, "content_#{@@filex}").set(file_path + file_name)
    @@filex+=1
  end

  # Clicks the Upload Files Now button and instantiates the
  # PortfolioAttachFiles Class.
  def upload_files_now
    frm.button(:value=>"Upload Files Now").click
    sleep 1 # TODO - use a wait clause here
    @@filex=0
    PortfolioAttachFiles.new(@browser)
  end

  # Clicks the Add Another File link.
  def add_another_file
    frm.link(:text=>"Add Another File").click
  end

end

#
class PortfolioContent < BasePage

  frame_element

  # Clicks the Continue button and instantiates the
  # SupportingFilesPortfolio Class.
  def continue
    frm.button(:value=>"Continue").click
    SupportingFilesPortfolio.new(@browser)
  end


  element(:type) { |b| b.frm.select(:id=>"item.type") }
  element(:name) { |b| b.frm.text_field(:id=>"item.name-id") }
  element(:title) { |b| b.frm.text_field(:id=>"item.title-id") }
  element(:description) { |b| b.frm.text_field(:id=>"item.description-id") }
  action(:add_to_list) { |b| b.frm.button(:value=>"Add To List").click }
  element(:image) { |b| b.frm.checkbox(:id=>"image-id") }

end

#
class SupportingFilesPortfolio < BasePage

  frame_element

  # Clicks the Finish button and instantiates
  # the PortfolioTemplates Class.
  def finish
    frm.button(:value=>"Finish").click
    PortfolioTemplates.new(@browser)
  end

  # Clicks the Select File link and instantiates
  # the PortfolioAttachFiles Class.
  def select_file
    frm.link(:text=>"Select File").click
    PortfolioAttachFiles.new(@browser)
  end


  action(:add_to_list) { |b| b.frm.button(:value=>"Add To List").click }
  element(:name) { |b| b.frm.text_field(:id=>"fileRef.usage-id") }

end