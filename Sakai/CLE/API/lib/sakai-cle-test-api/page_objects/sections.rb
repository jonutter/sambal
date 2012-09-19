#================
# Sections - Site Management
#================

class SectionsBase < BasePage

  frame_element
  basic_page_elements

  class << self
    def menu_elements
      # Clicks the Add Sections button/link and instantiates
      # the AddEditSections Class.
      action(:add_sections) { |b| b.frm.link(:text=>"Add Sections").click }
      action(:overview) { |b| b.frm.link(:text=>"Overview").click }
      action(:student_memberships) { |b| b.frm.link(:text=>"Student Memberships").click }
      action(:options) { |b| b.frm.link(:text=>"Options").click }
    end
  end
end

# Topmost page for Sections in Site Management
class Sections < SectionsBase

  menu_elements

  # Clicks the Edit link for the specified section.
  # Then instantiates the AddEditSections class.
  def edit(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/).link(:text=>/Edit/).click
    AddEditSections.new(@browser)
  end

  def assign_tas(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/).link(:text=>/Assign TAs/).click
    AssignTeachingAssistants.new(@browser)
  end

  def assign_students(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/).link(:text=>/Assign Students/).click
    AssignStudents.new(@browser)
  end

  def check(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/).checkbox(:name=>/remove/).set
  end

  def section_names
    names = []
    frm.table(:class=>/listHier/).rows.each do |row|
      if row.td(:class=>"leftIndent").exist?
        names << row.td(:class=>"leftIndent").div(:index=>0).text
      end
    end
    return names
  end

  def remove_sections
    frm.button(:value=>"Remove Sections").click
    Sections.new(@browser)
  end

  # Returns the text of the Teach Assistant cell for the specified
  # Section.
  def tas_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[1].text
  end

  #
  def days_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[2].text
  end

  #
  def time_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[3].text
  end

  #
  def location_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[4].text
  end

  #
  def current_size_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[5].text
  end

  #
  def availability_for(title)
    frm.table(:class=>/listHier/).row(:text=>/#{Regexp.escape(title)}/)[6].text
  end

  def alert_text
    frm.div(:class=>"validation").text
  end

  def success_text
    frm.div(:class=>"success").text
  end

end

# Methods in this class currently do not support
# adding multiple instances of sections simultaneously.
# That will be added at some future time.
# The same goes for adding days with different meeting times. This will hopefully
# be supported in the future.
class AddEditSections < SectionsBase

  menu_elements

  # The Update button is only available when editing an existing Sections record.
  def update
    frm.button(:value=>"Update").click
    if frm.div(:class=>"validation").exist?
      AddEditSections.new(@browser)
    else
      Sections.new(@browser)
    end
  end

  # This method takes an array object containing strings of the
  # days of the week and then clicks the appropriate checkboxes, based
  # on those strings.
  def check_days(array)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:monday/).set if array.include?(/mon/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:tuesday/).set if array.include?(/tue/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:wednesday/).set if array.include?(/wed/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:thursday/).set if array.include?(/thu/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:friday/).set if array.include?(/fri/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:saturday/).set if array.include?(/sat/i)
    frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:sunday/).set if array.include?(/sun/i)
  end

  element(:category) { |b| b.frm.select(:id=>/SectionsForm:category/) }
  element(:name) { |b| b.frm.text_field(:id=>/SectionsForm:sectionTable:0:titleInput/) }
  element(:monday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:monday/) }
  element(:tuesday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:tuesday/) }
  element(:wednesday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:wednesday/) }
  element(:thursday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:thursday/) }
  element(:friday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:friday/) }
  element(:saturday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:saturday/) }
  element(:sunday) { |b| b.frm.checkbox(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:sunday/) }
  element(:start_time) { |b| b.frm.text_field(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:startTime/) }
  element(:end_time) { |b| b.frm.text_field(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:endTime/) }
  element(:location) { |b| b.frm.text_field(:id=>/SectionsForm:sectionTable:0:meetingsTable:0:location/) }
  element(:startAM) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:meetingsTable:0:startTimeAm/, :index=>0) }
  element(:startPM) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:meetingsTable:0:startTimeAm/, :index=>1) }
  element(:endAM) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:meetingsTable:0:endTimeAm/, :index=>0) }
  element(:endPM) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:meetingsTable:0:endTimeAm/, :index=>1) }
  element(:unlimited_students) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:limit/, :index=>0) }
  element(:limited_students) { |b| b.frm.radio(:name=>/SectionsForm:sectionTable:0:limit/, :index=>1) }
  element(:max_students) { |b| b.frm.text_field(:id=>/SectionsForm:sectionTable:0:maxEnrollmentInput/) }

end

#
class AssignTeachingAssistants < SectionsBase

  menu_elements

  def assign_TAs
    frm.button(:value=>"Assign TAs").click
    Sections.new(@browser)
  end

  element(:available_tas) { |b| b.frm.select(:id=>"memberForm:availableUsers") }
  element(:assigned_tas) { |b| b.frm.select(:id=>"memberForm:selectedUsers") }
  action(:assign) { |b| b.frm.button(:value=>">").click }
  action(:unassign) { |b| b.frm.button(:value=>"<").click }
  action(:assign_all) { |b| b.frm.button(:value=>">>").click }
  action(:unassign_all) { |b| b.frm.button(:value=>"<<").click }

end

#
class AssignStudents < SectionsBase

  menu_elements

  def assign_students
    frm.button(:value=>"Assign students").click
    Sections.new(@browser)
  end

  element(:available_students) { |b| b.frm.select(:id=>"memberForm:availableUsers") }
  element(:assigned_students) { |b| b.frm.select(:id=>"memberForm:selectedUsers") }
  action(:assign) { |b| b.frm.button(:value=>">").click }
  action(:unassign) { |b| b.frm.button(:value=>"<").click }
  action(:assign_all) { |b| b.frm.button(:value=>">>").click }
  action(:unassign_all) { |b| b.frm.button(:value=>"<<").click }

end

# The Options page for Sections.
class SectionsOptions < SectionsBase

  menu_elements

  element(:students_can_sign_up) { |b| b.frm.checkbox(:id=>"optionsForm:selfRegister") }
  element(:students_can_switch) { |b| b.frm.checkbox(:id=>"optionsForm:selfSwitch") }

  action(:update) { |b| b.frm.button(:id=>"optionsForm:_idJsp50").click }
  action(:cancel) { |b| b.frm.button(:id=>"optionsForm:_idJsp51").click }

end

# The Add Sections Page in Site Management
class AddSections < SectionsBase

  menu_elements

  element(:num_to_add) { |b| b.frm.select_list(:id=>"addSectionsForm:numToAdd") }
  element(:category) { |b| b.frm.select_list(:id=>"addSectionsForm:category") }
  action(:cancel) { |b| b.frm.button(:id=>"addSectionsForm:_idJsp90").click }
  # Note that the following field definitions are appropriate for
  # ONLY THE FIRST instance of each of the fields. The Add Sections page
  # allows for an arbitrary number of these fields to exist.
  # If you are going to test the addition of multiple sections
  # and/or meetings, then their elements will have to be
  # explicitly called or defined in the test scripts themselves.
  element(:name) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:titleInput") }
  element(:unlimited_size) { |b| b.frm.radio(:name=>"addSectionsForm:sectionTable:0:limit") }
  element(:limited_size) { |b| b.frm.select_list(:name=>"addSectionsForm:sectionTable:0:limit") }
  element(:max_enrollment) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:maxEnrollmentInput") }
  element(:monday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:monday") }
  element(:tuesday) { |b| b.frm.checkbox(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:tuesday") }
  element(:wednesday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:wednesday") }
  element(:thursday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:thursday") }
  element(:friday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:friday") }
  element(:saturday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:saturday") }
  element(:sunday) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:sunday") }
  element(:start_time) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTime") }
  element(:start_am) { |b| b.frm.select_list(:name=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm") }
  element(:start_pm) { |b| b.frm.select_list(:name=>"addSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm") }
  element(:end_time) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTime") }
  element(:end_am) { |b| b.frm.select_list(:name=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm") }
  element(:end_pm) { |b| b.frm.select_list(:name=>"addSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm") }
  element(:location) { |b| b.frm.text_field(:id=>"addSectionsForm:sectionTable:0:meetingsTable:0:location")  }
  action(:add_days) { |b| b.frm.link(:id=>"addSectionsForm:sectionTable:0:addMeeting").click }

end

# Exactly like the Add Sections page, but used when editing an existing section
class EditSections < SectionsBase

  menu_elements

  element(:num_to_add) { |b| b.frm.select_list(:id=>"editSectionsForm:numToAdd") }
  element(:category) { |b| b.frm.select_list(:id=>"editSectionsForm:category") }
  action(:cancel) { |b| b.frm.button(:id=>"editSectionsForm:_idJsp90").click }
  # Note that the following field definitions are appropriate for
  # ONLY THE FIRST instance of each of the fields. The Edit Sections page
  # allows for an arbitrary number of these fields to exist.
  # If you are going to test the editing of multiple sections
  # and/or meetings, then their elements will have to be
  # explicitly called or defined in the test scripts themselves.
  element(:name) { |b| b.frm.text_field(:id=>"editSectionsForm:sectionTable:0:titleInput") }
  element(:unlimited_size) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:limit") }
  element(:limited_size) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:limit") }
  element(:max_enrollment) { |b| b.frm.text_field(:id=>"editSectionsForm:sectionTable:0:maxEnrollmentInput") }
  element(:monday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:monday") }
  element(:tuesday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:tuesday") }
  element(:wednesday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:wednesday") }
  element(:thursday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:thursday") }
  element(:friday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:friday") }
  element(:saturday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:saturday") }
  element(:sunday) { |b| b.checkbox(id=>"editSectionsForm:sectionTable:0:meetingsTable:0:sunday") }
  element(:start_time) { |b| b.frm.text_field(:id=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTime") }
  element(:start_am) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm") }
  element(:start_pm) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:meetingsTable:0:startTimeAm") }
  element(:end_time) { |b| b.frm.text_field(:id=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTime") }
  element(:end_am) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm") }
  element(:end_pm) { |b| b.frm.select_list(:name=>"editSectionsForm:sectionTable:0:meetingsTable:0:endTimeAm") }
  element(:location) { |b| b.frm.text_field(:id=>"editSectionsForm:sectionTable:0:meetingsTable:0:location") }
  action(:add_days) { |b| b.frm.link(:id=>"editSectionsForm:sectionTable:0:addMeeting").click }

end

# The Sections page
# found in the SITE MANAGEMENT menu for a Site
class SectionsOverview < SectionsBase

  menu_elements

  action(:sort_name) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp54").click }
  action(:sort_ta) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp73").click }
  action(:sort_day) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp78").click }
  action(:sort_time) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp83").click }
  action(:sort_location) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp88").click }
  action(:sort_current_size) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp93").click }
  action(:sort_avail) { |b| b.frm.link(id=>"overviewForm:sectionsTable:_idJsp97").click }

end