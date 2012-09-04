class ViewPopulation < BasePage

  expected_element :name_label

  def frm
    self.frame(class: "fancybox-iframe")
  end
  
  action(:expand_all) { |b| b.frm.button(text: "Expand All").click; b.loading.wait_while_present }
  action(:collapse_all) { |b| b.frm.button(text: "Collapse All").click; b.loading.wait_while_present }
  action(:close) { |b| b.frm.button(text: "Close").click; b.loading.wait_while_present }
  
  element(:name_label) {|b| b.frm.label(id: "u19_label")}
  value(:header) { |b| b.frm.h1(class: "uif-headerText").text }
  value(:name) { |b| b.frm.div(id: "u19").span(id: "u19").text }
  value(:description) { |b| b.frm.div(id: "u33").span(id: "u33").text }
  value(:state) { |b| b.frm.div(id: "u47").span(id: "u47").text }
  value(:rule) { |b| b.frm.div(id: "u75").span(id: "u75").text }
  value(:operation) { |b| b.frm.div(id: "u61").span(id: "u61").text }
  value(:reference_population) { |b| b.frm.div(id: "u89").span(id: "u89").text }

  def populations_list
    pops = []
    self.frm.table(class: "uif-tableCollectionLayout").rows.each { |row| pops << row.span.text }
    pops[1..-1] #2nd to last
  end

end