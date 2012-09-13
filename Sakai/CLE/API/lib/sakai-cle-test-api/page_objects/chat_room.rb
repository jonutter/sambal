#================
# Chat Room Pages
#================

#
class ChatRoom < BasePage

  frame_element

  def total_messages_shown
    @browser.frame(:class=>"wcwmenu").div(:id=>"chat2_messages_shown_total").text
  end

end