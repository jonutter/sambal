#================
# Realms Pages
#================

# Realms page
class Realms < BasePage

  frame_element

  action(:new_realm) { |b| b.frm.link(:text=>"New Realm").click }
  action(:search) { |b| b.frm.link(:text=>"Search").click }
  element(:select_page_size) { |b| b.frm.select_list(:name=>"selectPageSize") }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }


end