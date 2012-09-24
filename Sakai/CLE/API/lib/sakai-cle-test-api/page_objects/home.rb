# Topmost page for a Site in Sakai
class Home < BasePage

  frame_element

  # Because the links below are contained within iframes
  # we need the in_frame method in place so that the
  # links can be properly parsed in the PageObject
  # methods for them.
  # Note that the iframes are being identified by their
  # index values on the page. This is a very brittle
  # method for identifying them, but for now it's our
  # only option because both the <id> and <name>
  # tags are unique for every site.
  # Site Information Display, Options button
  action(:site_info_display_options) { |b| b.frm.link(:text=>"Options").click }

  # Recent Announcements Options button
  action(:recent_announcements_options) { |b| b.frm.link(:text=>"Options").click }
  # Link for New In Forms
  action(:new_in_forums) { |b| b.frm.link(:text=>"New Messages").click }
  element(:number_of_announcements) { |b| b.frm.text_field(:id=>"itemsEntryField") }
  action(:update_announcements) { |b| b.frm.button(:name=>"eventSubmit_doUpdate").click }


  # Gets the text of the displayed announcements, for
  # test case verification
  def announcements_list
    list = []
    links = @browser.frame(:index=>2).links
    links.each { |link| list << link.text }
    list.delete_if { |item| item=="Options" } # Deletes the Options link if it's there.
    return list
  end

end