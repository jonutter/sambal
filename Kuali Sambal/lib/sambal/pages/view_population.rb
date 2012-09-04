class ViewPopulation < BasePage

  wrapper_elements
  frame_element

  expected_element :name_label

  element(:name_label) {|b| b.frm.div(data_label: "Name").label }
  value(:name) { |b| b.frm.div(data_label: "Name").span(index: 1).text }
  value(:description) { |b| b.frm.div(data_label: "Description").span(index: 1).text }
  value(:state) { |b| b.frm.div(data_label: "State").span(index: 1).text }
  value(:rule) { |b| b.frm.div(id: "u75").span(index: 2).text }
  value(:operation) { |b| b.frm.div(data_label: "Operation").span(index: 2).text }
  value(:reference_population) { |b| b.frm.div(data_label: "Reference Population").span(index: 1).text }

  element(:child_populations_table) { |b| b.frm.table(id: "u200") }

  def child_populations
    pops = []
    child_populations_table.rows.each do |row|
      pops << row.text
    end
    pops.delete_if { |item| item == "* Name" }
    pops
  end

end