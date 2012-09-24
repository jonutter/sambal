# The Page that appears when you are not in a particular Site
# Note that this page differs depending on what user is logged in.
# The definitions below include all potential objects. We may
# have to split this class out into user-specific classes.
class MyWorkspace < BasePage

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
  # Calendar Options button
  action(:calendar_options) { |b| b.frm.link(:text=>"Options").click }

  # My Workspace Information Options
  action(:my_workspace_information_options) { |b| b.frm.link(:text=>"Options").click }
  # Message of the Day, Options button
  action(:message_of_the_day_options) { |b| b.frm.link(:text=>"Options").click }


  element(:select_page_size) { |b| b.frm.select_list(:id=>"selectPageSize").click }
  action(:next) { |b| b.frm.button(:name=>"eventSubmit_doList_next").click }
  action(:last) { |b| b.frm.button(:name=>"eventSubmit_doList_last").click }
  action(:previous) { |b| b.frm.button(:name=>"eventSubmit_doList_prev").click }
  action(:first) { |b| b.frm.button(:name=>"eventSubmit_doList_first").click }

  # Returns an array of strings of the Calendar Events listed below
  # the Calendar
  def calendar_events
    events = []
    table = @browser.frame(:class=>"portletMainIframe", :index=>2).table(:id=>"calendarForm:datalist_event_list")
    table.wait_until_present
    table.rows.each do |row|
      events << row.link.text
    end
    return events
  end
end