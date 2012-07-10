class CalendarSearch < BasePage

  wrapper_elements
  frame_element

  element(:search_for)  { |b| b.frame_el.select(name: "calendarType") }
  element(:name) { |b| b.frame_el.text_field(name: "name") }
  element(:year) { |b| b.frame_el.text_field(name: "year") }
  element(:search_results) { |b| b.table(class: "uif-tableCollectionLayout") }

  action(:search) { |b| b.frame_el.button(text: "Search") }

  def search_for_academic_calendar nm, yr
    search_for.set "Academic Calendar"
    setnameyear nm, yr
  end

  def search_for_holiday_calendar nm, yr
    search_for.set "Holiday Calendar"
    setnameyear nm, yr
  end

  def search_for_academic_term nm, yr
    search_for.set "Academic Term"
    setnameyear nm, yr
  end

  private

  def setnameyear nm, yr
    name.set nm
    year.set yr
    search
    loading.wait_while_present
  end

end