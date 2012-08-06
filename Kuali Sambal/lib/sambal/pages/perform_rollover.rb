class PerformRollover < BasePage

  wrapper_elements
  frame_element

  element(:target_term) { |b| b.frm.text_field(name: "targetTermCode") }
  element(:source_term) { |b| b.frm.text_field(name: "sourceTermCode") }

  value(:target_term_code) { |b| b.frm.span(id: "u155").text }
  value(:target_term_start_date) { |b| b.frm.span(id: "u166").text }
  value(:target_term_end_date) { |b| b.frm.span(id: "u177").text }

  action(:target_term_go) { |b| b.frm.button(id: "u130").click }
  action(:source_term_go) { |b| b.frm.button(id: "u263").click }

  element(:rollover_button) { |b| b.frm.button(id: "u46") }

  action(:rollover_course_offerings) { |b| b.rollover_button.click; b.loading.wait_while_present }

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