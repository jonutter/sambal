class RolloverManagement < BasePage

  header_elements
  footer_elements
  common_elements
  frame_element

  element(:target_term) { |b| b.frame_el.text_field(name: "targetTermCode") }
  element(:source_term) { |b| b.frame_el.text_field() }

  value(:target_term_code) { |b| b.frame_el.span(id: "u155").text }
  value(:target_term_start_date) { |b| b.frame_el.span(id: "u166").text }
  value(:target_term_end_date) { |b| b.frame_el.span(id: "u177").text }

  action(:target_term_go) { |b| b.frame_el.button(id: "u130").click }
  action(:source_term_go) { |b| b.frame_el.button(id: "u263").click }

  def select_target_term term
    target_term.set term
    target_term_go
    loading.wait_while_present
  end

  def select_source_term term
    source_term.set term
    sourcer_term_go
    loading.wait_while_present
  end

end