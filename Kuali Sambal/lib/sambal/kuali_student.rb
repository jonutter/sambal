module KualiStudent

  extend PageHelper

  #class << self; attr_accessor :browser end

  class BasePage < PageMaker

    def self.header_elements
      crucial_element(:select_an_area_el) { |b| b.div(:id=>"gwt-uid-10") }
      crucial_element(:logout_el) { |b| b.link(:text=>"Logout") }
      crucial_element(:curriculum_management_el) { |b| b.div(:id=>"gwt-debug-Curriculum-Management-label") }
      crucial_element(:home_el) { |b| b.div(:id=>"gwt-debug-Home-label") }
      crucial_element(:organization_mgt_el) { |b| b.div(:id=>"gwt-debug-Organization-Management-label") }
      crucial_element(:workflow_doc_search_el) { |b| b.div(:id=>"gwt-debug-Workflow-Doc-Search-label") }
      crucial_element(:rice_el) { |b| b.div(:id=>"gwt-debug-Rice-label") }

      action(:logout) { |p| p.logout_link.click }

      def select_an_area
        select_an_area_el.wait_until_present
        select_an_area_el.click
      end

      def open_curriculum_management
        select_an_area
        curriculum_management_el.click
      end

      def open_home
        select_an_area
        home_el.click
      end

      def open_organization_management
        select_an_area
        organization_mgt_el.click
      end

      def open_workflow_doc_search
        select_an_area
        workflow_doc_search_el.click
      end

      def open_rice
        select_an_area
        rice_el.click
      end

    end

    def self.footer_elements
      element(:line_1_el) { |b| b.div(:class=>"KS-Footer-Line1") }
      element(:acknowledgements_el) { |b| b.link(:text=>"Acknowledgements") }

      action(:acknowledgements) { |p| acknowledgements_element.click }
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