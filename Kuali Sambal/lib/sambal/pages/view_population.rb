class ViewPopulation < BasePage

  def frm
    self.frame(class=>"fancybox-iframe")
  end
  
  action(:expand_all) { |b| b.frm.button(text: "Expand All").click; b.loading.wait_while_present }
  action(:collapse_all) { |b| b.frm.button(text: "Collapse All").click; b.loading.wait_while_present }
  action(:close) { |b| b.frm.button(text: "Close").click; b.loading.wait_while_present }
  
  value(:header) { |b| b.frm.h1(class: "uif-headerText").text }
  value(:name) { |b| b.frm.span(id: "u19").text }
  value(:description) { |b| b.frm.span(id: "u33").text }
  value(:state) { |b| b.frm.span(id: "u47").text }
  value(:rule) { |b| b.frm.span(id: "u75").text }
  value(:operation) { |b| b.frm.span(id: "u61").text }
  value(:reference_population) { |b| b.frm.span(id: "u89").text }

  def populations_list
    pops = []
    self.table(class: "uif-tableCollectionLayout").cells(class: "uif-field").each { |cell| pops << cell.text }
    pops
  end

end