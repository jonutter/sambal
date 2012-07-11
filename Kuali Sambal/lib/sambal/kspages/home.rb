class KualiStudent::HomePage < KualiStudent::BasePage

  expected_element :frame, :class=>"gwt-Frame KS-Action-List"
  expected_title "Kuali Student: Home"

  header_elements
  footer_elements

  # Action List Sub Page Elements...

  crucial_element(:frame_el) { |b| b.frame(:class=>"gwt-Frame KS-Action-List") }
  element(:outbox_el) { |b| b.frame_el.link(:href=>"ActionList.do?methodToCall=start&viewOutbox=true") }
  element(:preferences_el) { |b| b.frame_el.button(:title=>"preferences") }
  element(:refresh_el) { |b| b.frame_el.button(:title=>"refresh") }
  element(:filter_el) { |b| b.frame_element.button(:title=>"filter") }
  element(:username) { |b| b.frame_el.text_field(:name=>"helpDeskActionListUserName") }
  element(:action_list_login_el) { |b| b.frame_el.button(:name=>"methodToCall.helpDeskActionListLogin") }
  element(:clear_list_el) { |b| b.frame_el.link(:href=>/clearHelpDeskActionListUser/) }

  action(:outbox) { |p| p.outbox_el.click }
  action(:preferences) { |p| p.preferences_el.click }

end

class KualiStudent::ActionListFilter < KualiStudent::BasePage

  header_elements
  footer_elements

  crucial_element(:frame_el) { |b| b.frame(:class=>"gwt-Frame KS-Action-List") }
  element(:document_title) { |b| b.frame_el.text_field(:name=>"filter.documentTitle") }
  element(:exclude_document_title) { |b| b.frame_el.checkbox(:name=>"filter.excludeDocumentTitle") }
  element(:document_route_status) { |b| b.frame_el.select(:name=>"filter.docRouteStatus") }
  element(:action_requested) { |b| b.frame_el.select(:name=>"filter.actionRequestCd") }
  element(:exclude_action_requested) { |b| b.frame_el.checkbox(:name=>"filter.excludeActionRequestCd") }
  element(:action_requested_group) { |b| b.frame_el.select(:name=>"filter.groupIdString") }
  element(:exclude_action_requested_group) { |b| b.frame_el.checkbox(:name=>"filter.excludeGroupId") }
  element(:document_type_el) { |b| b.frame_el.button(:name=>"methodToCall.performLookup.(!!org.kuali.rice.kew.doctype.bo.DocumentType!!).(((name:docTypeFullName))).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor") }
  element(:exclude_document_type) { |b| b.frame_el.checkbox(:name=>"filter.excludeDocumentType") }
  element(:date_created_from) { |b| b.frame_el.text_field(:name=>"createDateFrom") }
  element(:date_created_to) { |b| b.frame_el.text_field(:name=>"createDateTo") }
  element(:exclude_date_created) { |b| b.frame_el.checkbox(:name=>"filter.excludeCreateDate") }
  element(:date_last_assigned_from) { |b| b.frame_el.text_field(:name=>"lastAssignedDateFrom") }
  element(:date_last_assigned_to) { |b| b.frame_el.text_field(:name=>"lastAssignedDateTo") }
  element(:exclude_date_last_assigned) { |b| b.frame_el.checkbox(:name=>"filter.excludeLastAssignedDate") }
  element(:filter_el) { |b| b.frame_el.button(:name=>"methodToCall.filter") }
  element(:clear_el) { |b| b.frame_el.button(:name=>"methodToCall.clear") }
  element(:reset_el) { |b| b.frame_el.link(:href=>"javascript:document.forms[0].reset()") }
  element(:cancel_el) { |b| b.frame_el.link(:href=>"ActionList.do?methodToCall=start") }
  #element(:) { |b| b.frame_el.(:name=>"") }
  #element(:) { |b| b.frame_el.(:name=>"") }
  #element(:) { |b| b.frame_el.(:name=>"") }
  #element(:) { |b| b.frame_el.(:name=>"") }

  action(:document_type_lookup) { |p| p.document_type_el.click }
  action(:filter) { |p| p.filter_el.click }
  action(:clear) { |p| p.clear_el.click }
  action(:reset) { |p| p.reset_el.click }
  action(:cancel) { |p| p.cancel_el.click }

end

class KualiStudent::DocumentTypeLookup < KualiStudent::BasePage

  header_elements
  footer_elements

  crucial_element(:frame_el) { |b| b.frame(:class=>"gwt-Frame KS-Action-List") }
  element(:parent_name_el) { |b| b.frame_el.button(:title=>"Search Parent Name") }
  element(:name) { |b| b.frame_el.text_field(:name=>"name") }
  element(:label) { |b| b.frame_el.text_field(:name=>"label") }
  element(:id) { |b| b.frame_el.text_field(:name=>"documentTypeId") }
  element(:active_indicator_yes) { |b| b.frame_el.radio(:title=>"Active Indicator - Yes") }
  element(:active_indicator_no) { |b| b.frame_el.radio(:title=>"Active Indicator - No") }
  element(:active_indicator_both) { |b| b.frame_el.radio(:title=>"Active Indicator - Both") }

  action(:parent_name_lookup) { |p| p.parent_name_el.click }
  action(:search) { |p| p.search_el.click }
  action(:clear) { |p| p.clear_el.click }
  action(:cancel) { |p| p.cancel_el.click }

end