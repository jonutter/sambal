#
class EmailArchive
  include ToolsMenu
  include PageObject
  def options
    frm.link(:text=>"Options").click
    EmailArchiveOptions.new(@browser)
  end

  # Returns an array containing the
  def email_list
  end

  in_frame(:class=>"portletMainIframe") do |frame|
    text_field(:search_field, :id=>"search", :frame=>frame)
    button(:search_button, :value=>"Search", :frame=>frame)

  end
end

class EmailArchiveOptions
  include ToolsMenu

end