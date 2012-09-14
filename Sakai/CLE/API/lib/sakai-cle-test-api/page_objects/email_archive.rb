#
class EmailArchive < BasePage

  frame_element

  # EmailArchiveOptions
  action(:options){ |b| b.frm.link(:text=>"Options").click }

  # Returns an array containing the
  def email_list
  end

  element(:search_field) { |b| b.frm.text_field(:id=>"search") }
  action(:search_button) { |b| b.frm.button(:value=>"Search").click }

end

class EmailArchiveOptions < BasePage

  frame_element

end