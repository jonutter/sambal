class PopulationsBase < BasePage

  wrapper_elements

  class << self

    def population_lookup_elements
      element(:keyword) { |b| b.frm.text_field(name: "lookupCriteria[keyword]") }
      element(:results_table) { |b| b.frm.table(index: 1) }  # Persistent ID needed!

      element(:active) { |b| b.frm.radio(value: "kuali.population.population.state.active") }
      element(:inactive) { |b| b.frm.radio(value: "kuali.population.population.state.inactive") }
      element(:both) { |b| b.frm.radio(value: "both") }
    end

    def population_attribute_elements
      element(:name) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.name") }
      element(:description) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.populationInfo.descr.plain") }
      element(:rule) { |b| b.frm.select(name: "document.newMaintainableObject.dataObject.populationRuleInfo.agendaIds[0]") }
      element(:population) { |b| b.frm.text_field(name: "newCollectionLines['document.newMaintainableObject.dataObject.childPopulations'].name") }
      element(:reference_population) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.referencePopulation.name") }

      action(:lookup_population) { |b| b.frm.button(id: "u275_add").click; b.loading.wait_while_present } # Persistent ID needed!
      action(:lookup_ref_population) { |b| b.frm.button(id: "u194").click; b.loading.wait_while_present } # Persistent ID needed!
      action(:add) { |b| b.frm.button(text: "add").click; b.loading.wait_while_present; sleep 1.5 } # Persistent ID needed! Note that there can be multiple "adds" on the screen. We need helpful ids for all.
    end

  end

end

module PopulationsSearch

  # Results Table Columns...
  POPULATION_NAME = 1
  POPULATION_DESCRIPTION = 2
  POPULATION_TYPE = 3
  POPULATION_STATE = 4

  # Clicks the 'return value' link for the named row
  def return_value(name)
    target_row(name).wait_until_present
    target_row(name).link(text: "return value").wait_until_present
    target_row(name).link(text: "return value").click
    loading.wait_while_present
  end

  # Clicks the 'edit' link for the named item in the results table
  def edit(name)
    target_row(name).wait_until_present
    target_row(name).link(text: "edit").click
    loading.wait_while_present
    sleep 0.5 # Needed because the text doesn't immediately appear in the Populations field for some reason
  end

  # Clicks the link for the named item in the results table
  def view(name)
    target_row(name).wait_until_present
    results_table.link(text: name).click
    loading.wait_while_present
  end

  # Returns the status of the named item from the results
  # table. Note that this method assumes that the specified
  # item is actually listed in the results table.
  def status(name)
    target_row(name).wait_until_present
    target_row(name)[POPULATION_STATE].text
  end

  # Returns an array containing the names of the items returned in the search
  def results_list
    names = []
    results_table.wait_until_present
    results_table.rows.each { |row| names << row[POPULATION_NAME].text }
    names.delete_if { |name| name == "" }
    names
  end

  private

  def target_row(name)
    results_table.row(text: /#{name}/)
  end

end

module PopulationEdit

  # Returns (as a string) one of the rules listed in the Rule selection list.
  def random_rule
    rules = []
    rule.options.to_a.each { |item| rules << item.text }
    rules.shuffle!
    rules[0]
  end

  def remove_population(name)
    self.div(text:/#{name}/).link(text: "X").click
    loading.wait_while_present
  end

end

class HoldBase < BasePage

  class << self
    def hold_elements
      element(:hold_name) { |b| b.frm.text_field(name: "name") }
      element(:category_name) { |b| b.frm.select(name: "typeKey") }
      element(:phrase) { |b| b.frm.text_field(name: "descr") }
      element(:owning_organization) { |b| b.frm.text_field(name: "id") }
      action(:lookup_owning_org) { |b| b.frm.button(title:"Search Field").click; b.loading.wait_while_present }
    end
  end
end

class OrganizationBase < BasePage

  class << self
    def organization_elements
      element(:short_name) { |b| b.frm.text_field(name: "lookupCriteria[shortName]") }
      element(:long_name) { |b| b.frm.text_field(name: "lookupCriteria[longName]") }
    end
  end

end