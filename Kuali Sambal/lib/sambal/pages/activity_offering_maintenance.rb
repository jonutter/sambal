class ActivityOfferingMaintenance < BasePage

  wrapper_elements
  frame_element

  expected_element :activity_code
  
  action(:submit) { |b| b.frm.button(text: "submit").click; b.loading.wait_while_present }
  
  element(:activity_code) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.aoInfo.activityCode") }
  element(:total_maximum_enrollment) { |b| b.frm.text_field(id: "maximumEnrollment_control") }
  element(:add_person_id) { |b| b.frm.text_field(name: "newCollectionLines['document.newMaintainableObject.dataObject.instructors'].offeringInstructorInfo.personId") }

  action(:lookup_person) { |b| b.frm.image(id: "u240_add").click; b.loading.wait_while_present } # Need persistent ID!
  
  element(:personnel_table) { |b| b.frm.table(id: "u108") } # Need persistent ID!
  
  element(:add_affiliation) { |b| b.frm.select(name: "newCollectionLines['document.newMaintainableObject.dataObject.instructors'].offeringInstructorInfo.typeKey") }
  element(:add_inst_effort) { |b| b.frm.text_field(name: "newCollectionLines['document.newMaintainableObject.dataObject.instructors'].sEffort") }
  
  action(:add_personnel) { |b| b.frm.button(id: "u180_add").click; b.loading.wait_while_present } # Needs persistent ID value

  def target_person_row(id)
    personnel_table.row(text: /#{Regexp.escape(id)}/)
  end

  def update_affiliation(id, affiliation)
    target_person_row(id).select affiliation
  end
  
  def update_inst_effort(id, effort)
    target_person_row(id).text_field.set effort
  end
  
  def delete_id(id)
    target_person_row(id).button.click
    loading.wait_while_present
  end
  
  element(:seat_pools_table) { |b| b.frm.table(id: "u288") } # Needs persistent ID!

  element(:add_pool_priority) { |b| b.frm.text_field(name: "newCollectionLines['document.newMaintainableObject.dataObject.seatpools'].seatPool.processingPriority") }
  element(:add_pool_seats) { |b| b.frm.text_filed(name: "seatLimit_add_control") }
  value(:add_pool_name) { |b| b.frm.text_field(name: "newCollectionLines['document.newMaintainableObject.dataObject.seatpools'].seatPoolPopulation.name").text }
  
  action(:lookup_population_name) { |b| b.seat_pools_table.button(title: "Search Field").click; b.loading.wait_while_present }
  
  element(:add_pool_expiration_milestone) { |b| b.frm.select(name: "newCollectionLines['document.newMaintainableObject.dataObject.seatpools'].seatPool.expirationMilestoneTypeKey") }

  action(:add_seat_pool) { |b| b.frm.button(id: "u360_add").click; b.loading.wait_while_present }

  def target_pool_row(pop_name)
    seat_pools_table.row(text: /#{Regexp.escape(pop_name)}/)
  end

  def remove(pop_name)
    target_pool_row(pop_name).button(text: "remove")
    loading.wait_while_present
  end

  def update_priority(pop_name, priority)
    target_pool_row(pop_name).text_field(name: /processingPriority/).set priority
  end

  def update_seats(pop_name, seats)
    target_pool_row(pop_name).text_field(name: /seatLimit/).set seats
  end

  def update_expiration_milestone(pop_name, milestone)
    target_pool_row(pop_name).text_field(name: /expirationMilestoneTypeKey/).set milestone
  end

  def pool_percentage(pop_name)
    target_pool_row(pop_name).div(id: /seatLimitPercent_line/).text
  end

  value(:seat_pool_count) { |b| b.frm.div(id: "seatpoolCount").span(id: "_span").text }
  value(:percent_seats_remaining) { |b| b.frm.div(id: "seatsRemaining").text[/\d+(?=%)/] }
  value(:seat_count_remaining) { |b| b.frm.div(id: "seatsRemaining").text[/\d+(?=.S)/] }
  value(:max_enrollment_count) { |b| b.frm.div(id: "seatsRemaining").text[/\d+(?=\))/] }
  
  element(:course_url) { |b| b.frm.text_field(name: "document.newMaintainableObject.dataObject.aoInfo.activityOfferingURL") }
  element(:requires_evaluation) { |b| b.frm.checkbox(name: "document.newMaintainableObject.dataObject.aoInfo.isEvaluated") }
  element(:honors_flag) { |b| b.frm.checkbox(name: "document.newMaintainableObject.dataObject.aoInfo.isHonorsOffering") }

end