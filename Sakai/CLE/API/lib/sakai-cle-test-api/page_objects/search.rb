#================
# Administrative Search Pages
#================

# The Search page in the Administration Workspace - "icon-sakai-search"
class Search < BasePage

  frame_element

  action(:admin) { |b| b.frm.link(:text=>"Admin").click }
  element(:search_field) { |b| b.frm.text_field(:id=>"search") }
  action(:search_button) { |b| b.frm.button(:name=>"sb").click }
  element(:this_site) { |b| b.frm.radio(:id=>"searchSite") }
  element(:all_my_sites) { |b| b.frm.radio(:id=>"searchMine") }

end


# The Search Admin page within the Search page in the Admin workspace
class SearchAdmin < BasePage

  frame_element

  action(:search) { |b| b.frm.link(:text=>"Search").click }
  action(:rebuild_site_index) { |b| b.frm.link(:text=>"Rebuild Site Index").click }
  action(:refresh_site_index) { |b| b.frm.link(:text=>"Refresh Site Index").click }
  action(:rebuild_whole_index) { |b| b.frm.link(:text=>"Rebuild Whole Index").click }
  action(:refresh_whole_index) { |b| b.frm.link(:text=>"Refresh Whole Index").click }
  action(:remove_lock) { |b| b.frm.link(:text=>"Remove Lock").click }
  action(:reload_index) { |b| b.frm.link(:text=>"Reload Index").click }
  action(:enable_diagnostics) { |b| b.frm.link(:text=>"Enable Diagnostics").click }
  action(:disable_diagnostics) { |b| b.frm.link(:text=>"Disable Diagnostics").click }

end