#================
# Aliases Pages
#================

# The Aliases page - "icon-sakai-aliases", found in the Administration Workspace
class Aliases < BasePage

  frame_element

  element(:search_field) { |b| b.frm.text_field(:id=>"search") }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }
  action(:new_alias) { |b| b.frm.link(:text=>"New Alias").click }
  action(:search_button) { |b| b.frm.button(:text=>"Search").click }
  element(:select_page_size) { |b| b.frm.select(:id=>"selectPageSize") }

end

# The Page that appears when you create a New Alias
class AliasesCreate < BasePage

  frame_element

  element(:alias_name) { |b| b.frm.text_field(:id=>"id") }
  element(:target) { |b| b.frm.text_field(:id=>"target") }
  action(:save) { |b| b.frm.button(:name=>"eventSubmit_doSave").click }
  action(:cancel) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }

end

# Page for editing an existing Alias record
class EditAlias < BasePage

  frame_element

  action(:remove_alias) { |b| b.frm.link(:text=>"Remove Alias").click }
  element(:target) { |b| b.frm.text_field(:id=>"target") }
  action(:save) { |b| b.frm.button(:name=>"eventSubmit_doSave").click }
  action(:cancel) { |b| b.frm.button(:name=>"eventSubmit_doCancel").click }

end