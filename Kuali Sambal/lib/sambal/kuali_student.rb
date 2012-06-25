module KualiStudent

  extend PageHelper

  class BasePage < PageMaker

    def self.header_elements
      element(:select_an_area) { |b| b.div(:id=>"gwt-uid-10") }

      action(:logout) { |b| b.link(:text=>"Logout").click }
    end

  end

end