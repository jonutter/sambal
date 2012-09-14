
#================
# Lesson Pages
#================

# Contains items common to most Lessons pages.
module LessonsMenu

  # Clicks on the Preferences link on the Lessons page,
  # then instantiates the LessonPreferences class.
  def preferences
    frm.link(:text=>"Preferences").click
    LessonPreferences.new(@browser)
  end

  def view
    frm.link(:text=>"View").click
    if frm.div(:class=>"meletePortletToolBarMessage").text=="Viewing student side..."
      ViewModuleList.new(@browser)
    else
      #FIXME
    end
  end

  def manage
    frm.link(:text=>"Manage").click
    LessonManage.new(@browser)
  end

  def author
    #FIXME
  end

end

# The Lessons page in a site ("icon-sakai-melete")
#
# Note that this class is inclusive of both the
# Instructor/Admin and the Student views of this page
# many methods will error out if used when in the
# Student view.
class Lessons < BasePage

  frame_element
  include LessonsMenu

  # Clicks the Add Module link, then
  # instantiates the AddModule class.
  #
  # Assumes the Add Module link is present
  # and will error out if it is not.
  def add_module
    frm.link(:text=>"Add Module").click
    AddEditModule.new(@browser)
  end

  # Clicks on the link that matches the supplied
  # name value, then instantiates the
  # AddEditLesson, or ViewLesson class, depending
  # on which page loads.
  #
  # Will error out if there is no
  # matching link in the list.
  def open_lesson(name)
    frm.link(:text=>name).click
    if frm.div(:class=>"meletePortletToolBarMessage").exist? && frm.div(:class=>"meletePortletToolBarMessage").text=="Editing module..."
      AddEditModule.new(@browser)
    else
      ViewModule.new(@browser)
    end
  end

  # Returns an array of the Module titles displayed on the page.
  def lessons_list
    list = []
    frm.table(:id=>/lis.+module.+form:table/).links.each do |link|
      if link.id=~/lis.+module.+form:table:.+:(edit|view)Mod/
        list << link.text
      end
    end
    return list
  end

  # Returns and array containing the list of section titles for the
  # specified module.
  def sections_list(module_name)
    list = []
    if frm.table(:id=>/lis.+module.+form:table/).row(:text=>/#{Regexp.escape(module_name)}/).table(:id=>/tablesec/).exist?
      frm.table(:id=>/lis.+module.+form:table/).row(:text=>/#{Regexp.escape(module_name)}/).table(:id=>/tablesec/).links.each do |link|
        if link.id=~/Sec/
          list << link.text
        end
      end
    end
    return list
  end

end

# The student user's view of a Lesson Module or Section.
class ViewModule < BasePage

  frame_element

  def sections_list
    list = []
    frm.table(:id=>"viewmoduleStudentform:tablesec").links.each { |link| list << link.text }
    return list
  end

  def next
    frm.link(:text=>"Next").click
    ViewModule.new(@browser)
  end

  # Returns the text of the Module title row
  def module_title
    frm.span(:id=>/modtitle/).text
  end

  # Returns the text of the Section title row
  def section_title
    frm.span(:id=>/form:title/).text
  end

  def content_include?(content)
    frm.form(:id=>"viewsectionStudentform").text.include?(content)
  end

end

# This is the Instructor's preview of the Student's view
# of the list of Lesson Modules.
class ViewModuleList < BasePage

  frame_element

  def open_lesson(name)
    frm.link(:text=>name).click
    LessonStudentSide.new(@browser)
  end

  def open_section(name)
    frm.link(:text=>name).click
    SectionStudentSide.new(@browser)
  end

end

# The instructor's preview of the student view of the lesson.
class LessonStudentSide < BasePage

  frame_element
  include LessonsMenu

end

# The instructor's preview of the student's view of the section.
class SectionStudentSide < BasePage

  frame_element
  include LessonsMenu

end

# The Managing Options page for Lessons
class LessonManage < BasePage

  frame_element
  include LessonsMenu

  def manage_content
    frm.link(:text=>"Manage Content").click
    LessonManageContent.new(@browser)
  end

  def sort
    frm.link(:text=>"Sort").click
    LessonManageSort.new(@browser)
  end

  # Clicks the Import/Export button and
  # instantiates the LessonImportExport class.
  def import_export
    frm.link(:text=>"Import/Export").click
    LessonImportExport.new(@browser)
  end

end

# The Sorting Modules and Sections page in Lessons
class LessonManageSort < BasePage

  frame_element

  def view
    frm.link(:text=>"View").click
    if frm.div(:class=>"meletePortletToolBarMessage").text=="Viewing student side..."
      ViewModuleList.new(@browser)
    else
      #FIXME
    end
  end

  action(:sort_modules) { |b| b.frm.link(:id=>"SortSectionForm:sortmod").click }
  action(:sort_sections) { |b| b.frm.link(:id=>"SortModuleForm:sortsec").click }

end

# The Import/Export page in Manage Lessons for a Site
class LessonImportExport < BasePage

  frame_element
  include LessonsMenu

  # Uploads the file specified - meaning that it enters
  # the target file information, then clicks the import
  # button.
  #
  # The file path is an optional parameter.
  def upload_IMS(file_name, file_path="")
    frm.file_field(:name, "impfile").set(file_path + file_name)
    frm.link(:id=>"importexportform:importModule").click
    frm.table(:id=>"AutoNumber1").div(:text=>"Processing...").wait_while_present
  end

  # Returns the text of the alert box.
  def alert_text
    frm.span(:class=>"BlueClass").text
  end

end

# The User preference options page for Lessons.
#
# Note that this class is inclusive of Student
# and Instructor views of the page. Thus,
# not all methods in the class will work
# at all times.
class LessonPreferences < BasePage

  frame_element

  # Clicks the View button
  # then instantiates the Lessons class.
  def view
    frm.link(:text=>"View").click
    Lessons.new(@browser)
  end

  element(:expanded) { |b| b.radio(:name=>"UserPreferenceForm:_id5", :index=>0) }
  element(:collapsed) { |b| b.radio(:name=>"UserPreferenceForm:_id5", :index=>1) }
  action(:set) { |b| b.frm.link(:id=>"UserPreferenceForm:SetButton").click }
  
end

# This Class encompasses methods for both the Add and the Edit pages for Lesson Modules.
class AddEditModule < BasePage

  frame_element

  # Clicks the Add button for the Lesson Module
  # then instantiates the ConfirmModule class.
  def add
    frm.link(:id=>/ModuleForm:submitsave/).click
    ConfirmModule.new(@browser)
  end

  def add_content_sections
    frm.link(:id=>/ModuleForm:sectionButton/).click
    AddEditContentSection.new(@browser)
  end

  element(:title) { |b| b.text_field(:id=>/ModuleForm:title/) }
  element(:description) { |b| b.text_field(:id=>/ModuleForm:description/) }
  element(:keywords) { |b| b.text_field(:id=>/ModuleForm:keywords/) }
  element(:start_date) { |b| b.text_field(:id=>/ModuleForm:startDate/) }
  element(:end_date) { |b| b.text_field( :id=>/ModuleForm:endDate/) }

end

# The confirmation page when you are saving a Lesson Module.
class ConfirmModule < BasePage

  frame_element

  # Clicks the Add Content Sections button and
  # instantiates the AddEditSection class.
  def add_content_sections
    frm.link(:id=>/ModuleConfirmForm:sectionButton/).click
    AddEditSection.new(@browser)
  end

  # Clicks the Return to Modules button, then
  # instantiates the AddEditModule class.
  def return_to_modules
    frm.link(:id=>/ModuleConfirmForm:returnButton/).click
    AddEditModule.new(@browser)
  end

end

# Page for adding a section to a Lesson.
class AddEditContentSection < BasePage

  frame_element
  include FCKEditor

  # Clicks the Add button on the page
  # then instantiates the ConfirmSectionAdd class.
  def add
    frm.link(:id=>/SectionForm:submitsave/).click
    ConfirmSectionAdd.new(@browser)
  end

  # Pointer to the Edit Text box of the FCKEditor
  # on the page.
  def content_editor
    frm.frame(:id, /SectionForm:fckEditorView:otherMeletecontentEditor_inputRichText___Frame/)
  end

  def add_content=(text)
    content_editor.td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  def source=(text)
    content_editor.td(:id, "xEditingArea").text_field(:class=>"SourceField").set text
  end

  def clear_content  # FIXME - This is an extra method now that we have the FCKEditor module
    content_editor.div(:title=>"Select All").fire_event("onclick")
    content_editor.send_keys :backspace
  end

  def select_url
    frm.link(:id=>"AddSectionForm:ContentLinkView:serverViewButton").click
    SelectingContent.new(@browser)
  end

  # This method clicks the Select button that appears on the page
  # then calls the LessonAddAttachment class.
  #
  # It assumes that the Content Type selection box has
  # already been updated to "Upload or link to a file in Resources".
  def select_or_upload_file
    frm.link(:id=>"AddSectionForm:ResourceHelperLinkView:serverViewButton").click
    LessonAddAttachment.new(@browser)
  end

  # Clicks the select button for "Upload or link to a file"
  # NOT for "Upload or link to a file in Resources"!
  def select_a_file
    frm.link(:id=>"AddSectionForm:ContentUploadView:serverViewButton").click
  end

  element(:title) { |b| b.text_field(:id=>/SectionForm:title/) }
  element(:instructions) { |b| b.text_field(:id=>/SectionForm:instr/) }
  element(:content_type) { |b| b.select(:id=>/SectionForm:contentType/) }
  element(:copyright_status) { |b| b.select(:id=>/SectionForm:ResourcePropertiesPanel:licenseCodes/) }
  element(:auditory) { |b| b.checkbox(:id=>/SectionForm:contentaudio/) }
  element(:textual) { |b| b.checkbox(:id=>/SectionForm:contentext/) }
  element(:visual, ) { |b| b.checkbox(:id=>/SectionForm:contentaudio/) }
  element(:url_title) { |b| b.text_field(:id=>/SectionForm:ResourcePropertiesPanel:res_name/) }
  element(:url_description) { |b| b.text_field(:id=>/SectionForm:ResourcePropertiesPanel:res_desc/) }
  element(:file_description) { |b| b.text_field(:id=>/SectionForm:ResourcePropertiesPanel:res_desc/) }

end

# Confirmation page for Adding (or Editing)
# a Section to a Module in Lessons.
class ConfirmSectionAdd < BasePage

  frame_element

  # Clicks the Add Another Section button
  # then instantiates the AddSection class.
  def add_another_section
    frm.link(:id=>/SectionConfirmForm:saveAddAnotherbutton/).click
    AddEditContentSection.new(@browser)
  end

  # Clicks the Finish button
  # then instantiates the Lessons class.
  def finish
    frm.link(:id=>/Form:FinishButton/).click
    Lessons.new(@browser)
  end

end

#
class SelectingContent < BasePage

  frame_element

  def continue
    frm.link(:id=>"ServerViewForm:addButton").click
    AddEditContentSection.new(@browser)
  end

  element(:new_url) { |b| b.text_field(:id=>"ServerViewForm:link") }
  element(:url_title) { |b| b.text_field(:id=>"ServerViewForm:link_title") }

end

#
class LessonAddAttachment < BasePage

  frame_element

  action(:continue) { |b| b.frm.link(:id=>"UploadServerViewForm:addButton").click }

  def upload_local_file(filename, filepath="")
    frm.file_field(:id=>"file1").set(filepath + filename)
  end

end