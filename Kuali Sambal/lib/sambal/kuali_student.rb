module KualiStudent

  extend PageHelper

  #class << self; attr_accessor :browser end

  class BasePage < PageMaker

    def self.header_elements
      element(:select_an_area_div) { |b| b.div(:id=>"gwt-uid-10") }
      element(:logout_link) { |b| b.link(:text=>"Logout") }
      element(:curriculum_management_div) { |b| b.div(:id=>"gwt-debug-Curriculum-Management-label") }

      action(:logout) { |p| p.logout_link.click }

      def open_curriculum_management
        select_an_area_div.wait_until_present
        select_an_area_div.click
        curriculum_management_div.click
      end

    end

    def self.footer_elements
      element(:line_1_div) { |b| b.div(:class=>"KS-Footer-Line1") }
      element(:acknowledgements_link) { |b| b.link(:text=>"Acknowledgements") }
    end

    def crucial_elements_exist?
      x = true
      @@crucial_elements[self.class].each { |page_item| x = false unless self.send(page_item).exists? }
      return x
    end

  end

  def wait_for_ajax(timeout=5)
    end_time = ::Time.now + timeout
    while self.execute_script("return jQuery.active") > 0
      sleep 0.2
      break if ::Time.now > end_time
    end
    self.wait(timeout + 10)
  end


end