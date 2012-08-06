class BasePage < PageMaker

  class << self

    def wrapper_elements
      crucial_element(:main_menu_el) { |b| b.link(title: "Main Menu") }
      crucial_element(:logout_el) { |b| b.button(value: "Logout") }
      crucial_element(:administration_el) { |b| b.link(title: "Administration") }

      action(:main_menu) { |p| p.main_menu_el.click }
      action(:provide_feedback) { |b| b.link(title: "Provide Feedback").click }
      action(:administration) { |p| p.administration_el.click }
      action(:action_list) { |b| b.link(title: "Action List").click }
      action(:doc_search) { |b| b.link(title: "Document Search").click }

      value(:build) { |b| b.div(id: "build").text }
      value(:logged_in_user) { |b| b.div(id: "login-info").text }

      value(:copyright) { |b| b.div(id: "footer-copyright").text }
      action(:acknowledgements) { |b| b.link(href: "acknowledgments.jsp").click }

      element(:loading) { |b| b.image(alt: "working...") }
    end

    def frame_element
      crucial_element(:frm) { |b| b.frame(id: "iframeportlet") }
    end

    def doc_info_elements
      value(:document_number) { |b| b.frm.span(id: "u11").text }
      value(:document_status) { |b| b.frm.span(id: "u28").text }
      value(:initiator_network_id) { |b| b.frm.span(id: "u45").text }
      value(:creation_timestamp) { |b| b.frm.span(id: "u62").text }
    end

    def green_search_buttons
      action(:search) { |b| b.frm.button(text: "Search").click; b.loading.wait_while_present }
      action(:clear_values) { |b| b.frm.button(text: "Clear Values").click; b.loading.wait_while_present }
      action(:cancel) { |b| b.frm.button(text: "Cancel").click; b.loading.wait_while_present }
      action(:close) { |b| b.frm.button(text: "Close").click; b.loading.wait_while_present }
    end

  end


end
