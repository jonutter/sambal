#================
# Feedback pages
#================

#
class Feedback < BasePage

  frame_element

  def add
    frm.link(:text=>"Add").click
    AddUpdateFeedback.new(@browser)
  end

  # Returns an array containing the titles
  # of the Feedback items listed on the page.
  def feedback_items
    items = []
    frm.table(:class=>"listHier lines nolines").rows.each_with_index do |row, index|
      next if index == 0
      items << row[0].text
    end
    return items
  end

end

#
class AddUpdateFeedback < BasePage

  frame_element


  element(:title) { |b| b.frm.text_field(:id=>"_idJsp1:title") }

end