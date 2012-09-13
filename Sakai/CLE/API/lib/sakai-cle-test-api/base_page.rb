class BasePage < PageMaker

  class << self

    def frame_element
      element(:frm) { |b| b.frame(:class=>"portletMainIframe") }
    end

  end

end
