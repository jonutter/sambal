class PopulationsBase < BasePage

  wrapper_elements

  element(:keyword) { |b| b.frm.text_field(name: "criteriaFields[keyword]") }
  element(:results_table) { |b| b.frm.table(id: "u67") }

  # Results Table Columns...
  NAME = 1
  DESCRIPTION = 2
  TYPE = 3
  STATE = 4

  element(:active) { |b| b.frm.radio(value: "kuali.population.population.state.active") }
  element(:inactive) { |b| b.frm.radio(value: "kuali.population.population.state.inactive") }
  element(:both) { |b| b.frm.radio(value: "both") }

  action(:search) { |b| b.frm.button(id: "u57").click; b.loading.wait_while_present }
  action(:clear_values) { |b| b.frm.button(id: "u58").click; b.loading.wait_while_present }
  action(:close) { |b| b.frm.button(id: "u62").click; b.loading.wait_while_present }

  # Clicks the 'return value' link for the named row
  def return_value(name)
    results_table.row(text: /#{name}/).link(text: "return value").click
    loading.wait_while_present
  end

  # Clicks the 'edit' link for the named item in the results table
  def edit(name)
    results_table.row(text: /#{name}/).link(text: "edit").click
    loading.wait_while_present
    sleep 0.5 # Needed because the text doesn't immediately appear in the Populations field for some reason
  end

  # Clicks the link for the named item in the results table
  def view(name)
    results_table.link(text: name).click
    loading.wait_while_present
  end

  # Returns the status of the named item from the results
  # table. Note that this method assumes that the specified
  # item is actually listed in the results table.
  def status(name)
    results_table.row(text: /#{name}/)[STATE].text
  end

  # Returns an array containing the names of the items returned in the search
  def results_list
    names = []
    results_table.rows.each { |row| names << row[NAME].text }
    names
  end

end