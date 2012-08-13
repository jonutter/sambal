class OrganizationLookup < OrganizationBase

  expected_element :short_name

  frame_element
  wrapper_elements
  green_search_buttons

  organization_elements

end

class OrgLookupPopUp < OrganzationBase

  expected_element :short_name

  def frm
    self.frame(class: "fancybox-iframe") # Persistent ID needed!
  end

  wrapper_elements
  green_search_buttons

  organization_elements

end