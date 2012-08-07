class CalendarSearch < BasePage

  wrapper_elements
  frame_element

  CALENDAR_NAME = 0
  CALENDAR_START_DATE = 1
  CALENDAR_END_DATE = 2
  CALENDAR_STATUS = 3

  element(:search_for)  { |b| b.frm.select(name: "calendarType") }
  element(:name) { |b| b.frm.text_field(name: "name") }
  element(:year) { |b| b.frm.text_field(name: "year") }
  element(:results_table) { |b| b.frm.table(class: "uif-tableCollectionLayout") }

  action(:search) { |b| b.frm.button(text: "Search").click; b.loading.wait_while_present }

  def search_for_academic_calendar nm, yr=""
    search_for.select "Academic Calendar"
    setnameyear nm, yr
  end

  def search_for_holiday_calendar nm, yr=""
    search_for.select "Holiday Calendar"
    setnameyear nm, yr
  end

  def search_for_academic_term nm, yr=""
    search_for.select "Academic Term"
    setnameyear nm, yr
  end

  def view calendar
    results_table.row(text: /#{calendar}/).link(text: "View").click
    loading.wait_while_present
  end

  def edit calendar
    results_table.row(text: /#{calendar}/).link(text: "Edit").click
    loading.wait_while_present
  end

  def copy calendar
    results_table.row(text: /#{calendar}/).link(text: "Copy").click
    loading.wait_while_present
  end

  def delete calendar
    results_table.row(text: /#{calendar}/).link(text: "Delete").click
    loading.wait_while_present
  end

  def calendar_status calendar
    results_table.row(text: /#{calendar}/)[CALENDAR_STATUS].text
  end

  def results_list
    list = []
    results_table.rows.each do |row|
      list << row[CALENDAR_NAME].text
    end
    list
  end

  private

  def setnameyear nm, yr
    name.set nm
    year.set yr
    search
  end

end