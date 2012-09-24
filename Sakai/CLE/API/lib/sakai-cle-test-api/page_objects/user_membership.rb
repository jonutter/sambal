#================
# User Membership Pages from Administration Workspace
#================

# User Membership page for admin users - "icon-sakai-usermembership"
class UserMembership < BasePage

  frame_element

  # Returns an array containing the user names displayed in the search results.
  def names
    names = []
    frm.table(:class=>/listHier/).rows.each do |row|
      names << row[2].text
    end
    names.delete_at(0)
    return names
  end

  # Returns the user id of the specified user (assuming that person
  # appears in the search results list, otherwise this method will
  # throw an error.)
  def user_id(name)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(name)}/)[0].text
  end

  # Returns the user type of the specified user (assuming that person
  # appears in the search results list, otherwise this method will
  # throw an error.)
  def type(name)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(name)}/)[4].text
  end

  # Returns the text contents of the "instruction" paragraph that
  # appears when there are no search results.
  def alert_text
    frm.p(:class=>"instruction").text
  end

  element(:user_type) { |b| b.frm.select_list(:id=>"userlistForm:selectType") }
  element(:user_authority) { |b| b.frm.select_list(:id=>"userlistForm:selectAuthority") }
  element(:search_field) { |b| b.frm.text_field(:id=>"userlistForm:inputSearchBox") }
  action(:search) { |b| b.frm.button(:id=>"userlistForm:searchButton").click }
  action(:clear_search) { |b| b.frm.button(:id=>"userlistForm:clearSearchButton").click }
  element(:page_size) { |b| b.frm.select_list(:id=>"userlistForm:pager_pageSize") }
  action(:export_csv) { |b| b.frm.button(:id=>"userlistForm:exportCsv").click }
  action(:export_excel) { |b| b.frm.button(:id=>"userlistForm:exportXls").click }
  action(:sort_user_id) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp14").click }
  action(:sort_internal_user_id) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp18").click }
  action(:sort_name) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp21").click }
  action(:sort_email) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp24").click }
  action(:sort_type) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp28").click }
  action(:sort_authority) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp31").click }
  action(:sort_created_on) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp34").click }
  action(:sort_modified_on) { |b| b.frm.link(id=>"userlistForm:_idJsp13:_idJsp37").click }

end