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