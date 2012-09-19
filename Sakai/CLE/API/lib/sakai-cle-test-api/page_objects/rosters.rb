#================
# Roster Pages for a Site
#================

#
class Roster < BasePage

  frame_element

  def find
    frm.button(:value=>"Find").click
    Roster.new @browser
  end

  def names
    list = []
    frm.table(:id=>"roster_form:rosterTable").rows.each do |row|
      list << row[0].text
    end
    list.delete_at(0)
    return list
  end

  # Clicks on the link on the page that matches the specified name.
  # Then instantiates the RosterProfileView class.
  # Note that it expects an exact match for the name string, otherwise
  # the script will error out.
  def view(name)
    frm.link(:text=>name).click
    RosterProfileView.new @browser
  end


  element(:name_or_id) { |b| b.frm.text_field(:id=>"roster_form:search") }

end

#
class RosterProfileView < BasePage

  frame_element

  def back
    frm.button(:value=>"Back").click
    Roster.new(@browser)
  end

  # Returns a hash containing the contents of the Public Information
  # table on the page, with the keys being the row headers and the values
  # being the row's data contents.
  def public_information
    hash = {}
    frm.table(:class=>"chefEditItem", :index=>0).rows.each do |row|
      hash.store(row[0].text, row[1].text)
    end
    return hash
  end

  # Returns a hash containing the contents of the Personal Information
  # table on the page, with the keys being the row headers and the values
  # being the row's data contents.
  def personal_information
    hash = {}
    frm.table(:class=>"chefEditItem", :index=>1).rows.each do |row|
      hash.store(row[0].text, row[1].text)
    end
    return hash
  end

end