class HoldIssueLookup < BasePage
  
  frame_element
  wrapper_elements
  
  element(:hold_name) { |b| b.frm.text_field(name: "name") }
  element(:category_name) { |b| b.frm.select(name: "typeKey") }
  element(:phrase) { |b| b.frm.text_field(name: "descr") }
  element(:owning_organization) { |b| b.frm.text_field(name: "id") }

  action(:lookup_owning_org) { |b| b.frm.button(title:"Search Field").click; b.loading.wait_while_present }

  element(:active) { |b| b.frm.radio(value: "active") }
  element(:inactive) { |b| b.frm.radio(value: "inactive") }
  
  action(:search) { |b| b.frm.button(text: "Search").click; b.loading.wait_while_present }

  element(:results_table) { |b| b.frm.table(id: "u115") } # Needs persistent id!

  def view(name)
    target_row(name).link(text: "View").click
    loading.wait_while_present
  end

  def edit(name)
    target_row(name).link(text: "Edit").click
    loading.wait_while_present
  end

  def delete(name)
    target_row(name).link(text: "Delete").click
    alert.ok
    loading.wait_while_present
  end

  def target_row(name)
    results_table.row(text: /#{Regexp.escape(name)}/)
  end

end