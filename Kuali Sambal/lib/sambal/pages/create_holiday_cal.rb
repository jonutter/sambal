class CreateHolidayCalendar < BasePage

  wrapper_elements
  frame_element

  expected_element :calendar_name
  
  element(:calendar_name) { |b| b.frm.text_field(name: "holidayCalendarInfo.name") }
  element(:organization) { |b| b.frm.select(name: "holidayCalendarInfo.adminOrgId") }
  element(:start_date) { |b| b.frm.text_field(name: "holidayCalendarInfo.startDate") }
  element(:end_date) { |b| b.frm.text_field(name: "holidayCalendarInfo.endDate") }
  element(:holiday_table) { |b| b.frm.table(class: "uif-tableCollectionLayout") }

  element(:holiday_type) { |b| b.frm.select(name: "newCollectionLines['holidays'].typeKey") }
  element(:holiday_start_date) { |b| b.frm.text_field(name: "newCollectionLines['holidays'].startDate") }
  element(:holiday_start_time) { |b| b.frm.text_field(name: "newCollectionLines['holidays'].startTime") }
  element(:holiday_start_meridian) { |b| b.frm.select(name: "") }
  element(:holiday_end_date) { |b| b.frm.text_field(name: "") }
  element(:holiday_end_time) { |b| b.frm.text_field(name: "") }
  element(:holiday_end_meridian) { |b| b.frm.text_field(name: "") }
  element(:all_day) { |b| b.frm.checkbox(name: "") }
  element(:date_range) { |b| b.frm.checkbox(name: "") }
  element(:instructional) { |b| b.frm.checkbox(name: "") }
  element(:add_button) { |b| b.frm.button(name: "") }

  action(:make_official) { |b| b.frm.button(name: "").click; b.loading.wait_while_present }
  action(:save) { |b| b.frm.button(name: "").click; b.loading.wait_while_present }

  def add_all_day_holiday(type, date, inst=false)
    holiday_type.set type
    holiday_start_date.set date
    all_day.set unless all_day.set?
    date_range.clear if date_range.set?
    instruct(inst)
  end

  def add_date_range_holiday(type, start_date, end_date, inst=false)
    all_day.set unless all_day.set?
    date_range.set unless date_range.set?
    holiday_type.set type
    holiday_start_date.set start_date
    holiday_end_date.set end_date
    instruct(inst)
  end

  def add_partial_day_holiday(type, start_date, start_time, start_meridian, end_time, end_meridian, inst=false)
    all_day.clear if all_day.set?
    date_range.clear if date_range.set?
    holiday_type.set type
    holiday_start_date.set start_date
    holiday_start_time.set start_time
    holiday_start_meridian.set start_meridian
    holiday_end_time.set end_time
    holiday_end_meridian.set end_meridian
    instruct(inst)
  end

  def add_partial_range_holiday(type, start_date, start_time, start_meridian, end_date, end_time, end_meridian, inst=false)
    all_day.clear if all_day.set?
    date_range.set unless date_range.set?
    holiday_type.set type
    holiday_start_date.set start_date
    holiday_start_time.set start_time
    holiday_start_meridian.set start_meridian
    holiday_end_date.set end_date
    holiday_end_time.set end_time
    holiday_end_meridian.set end_meridian
    instruct(inst)
  end

  def delete_holiday(holiday_type)
    target_row(holiday_type).button(text: "delete").click
    loading.wait_while_present
  end

  def edit_start_date(holiday_type, date)
    target_row(holiday_type).text_field(name: /startDate/).set date
  end

  def edit_start_time(holiday_type, time, meridian)
    target_row(holiday_type).checkbox(name: /allDay/).clear if target_row(holiday_type).checkbox(name: /allDay/).set?
    target_row(holiday_type).text_field(name: /startTime\d/).set time
    target_row(holiday_type).text_field(name: /startTimeAmPm/).set meridian
  end

  def edit_end_time(holiday_type, time, meridian)
    target_row(holiday_type).checkbox(name: /dateRange/).set unless target_row(holiday_type).checkbox(name: /dateRange/).set?
    target_row(holiday_type).text_field(name: /endTime\d/).set time
    target_row(holiday_type).text_field(name: /endTimeAmPm/).set meridian
  end

  def toggle_all_day(holiday_type)
    if target_row(holiday_type).checkbox(name: /allDay/).set?
      target_row(holiday_type).checkbox(name: /allDay/).clear
    else
      target_row(holiday_type).checkbox(name: /allDay/).set
    end
  end

  def toggle_range(holiday_type)
    if target_row(holiday_type).checkbox(name: /dateRange/).set?
      target_row(holiday_type).checkbox(name: /dateRange/).clear
    else
      target_row(holiday_type).checkbox(name: /dateRange/).set
    end
  end

  def toggle_instructional(holiday_type)
    if target_row(holiday_type).checkbox(name: /instructional/).set?
      target_row(holiday_type).checkbox(name: /instructional/).clear
    else
      target_row(holiday_type).checkbox(name: /instructional/).set
    end
  end

  private

  def target_row(holiday_type)
    holiday_table.row(text: /#{Regexp.escape(holiday_type)}/)
  end

  def instruct(instr)
    if instr
      instructional.set
    else
      instructional.clear
    end
  end

end