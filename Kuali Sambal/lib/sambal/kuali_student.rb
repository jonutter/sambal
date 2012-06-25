module KualiStudent

  extend PageHelper

  class BasePage < PageMaker

    def self.header_elements
      element(:select_an_area) { |b| b.div(:id=>"gwt-uid-10") }
      element(:logout_link) { |b| b.link(:text=>"Logout") }

      action(:logout) { |p| p.logout_link.click }
    end

  end

end