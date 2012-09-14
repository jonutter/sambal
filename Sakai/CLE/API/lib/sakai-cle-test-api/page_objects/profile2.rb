module Profile2Nav

  def preferences
    frm.link(:class=>"icon preferences").click
    Profile2Preferences.new @browser
  end

  def privacy
    frm.link(:text=>"Privacy").click
    Profile2Privacy.new @browser
  end

  def my_profile
    frm.link(:text=>"My profile").click
    Profile2.new(@browser)
  end

  def connections
    frm.link(:class=>"icon connections").click
    Profile2Connections.new @browser
  end

  def pictures
    frm.link(:text=>"Pictures").click
    Profile2Pictures.new @browser
  end

  def messages
    frm.link(:text=>"Messages").click
    Profile2Messages.new @browser
  end

  def search_for_connections
    frm.link(:class=>"icon search").click
    Profile2Search.new @browser
  end

end
#
class Profile2 < BasePage

  frame_element
  include Profile2Nav
  def edit_basic_info
    frm.div(:id=>"mainPanel").span(:text=>"Basic Information").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/myInfo:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def edit_contact_info
    frm.div(:id=>"mainPanel").span(:text=>"Contact Information").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/myContact:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def edit_staff_info
    frm.div(:id=>"mainPanel").span(:text=>"Staff Information").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/myStaff:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def edit_student_info
    frm.div(:id=>"mainPanel").span(:text=>"Student Information").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/myStudent:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def edit_social_networking
    frm.div(:id=>"mainPanel").span(:text=>"Social Networking").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/mySocialNetworking:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def edit_personal_info
    frm.div(:id=>"mainPanel").span(:text=>"Personal Information").fire_event("onmouseover")
    frm.div(:id=>"mainPanel").link(:href=>/myInterests:editButton/).click
    sleep 0.5
    Profile2.new @browser
  end

  def change_picture
    frm.div(:id=>"myPhoto").fire_event("onmouseover")
    frm.div(:id=>"myPhoto").link(:class=>"edit-image-button").click
    sleep 0.5
    Profile2.new @browser
  end

  # Enters the specified filename in the file field.
  #
  # Note that the file should be inside the data/sakai-cle-test-api folder.
  # The file or folder name used for the filename variable
  # should not include a preceding slash ("/") character.
  def image_file=(filename)
    frm.file_field(:name=>"picture").set(File.expand_path(File.dirname(__FILE__)) + "/../../data/sakai-cle-test-api/" + filename)
  end

  def upload
    frm.button(:value=>"Upload").click
    sleep 0.5
    Profile2.new @browser
  end

  def personal_summary=(text)
    frm.frame(:id=>"id1a_ifr").send_keys([:command, 'a'], :backspace)
    frm.frame(:id=>"id1a_ifr").send_keys(text)
  end

  def birthday(day, month, year)
    frm.text_field(:name=>"birthdayContainer:birthday").click
    frm.select(:class=>"ui-datepicker-new-year").wait_until_present
    frm.select(:class=>"ui-datepicker-new-year").select(year.to_i)
    frm.select(:class=>"ui-datepicker-new-month").select(month)
    frm.link(:text=>day.to_s).click
  end

  def save_changes
    frm.button(:value=>"Save changes").click
    Profile2.new @browser
  end

  # Returns the number (as a string) displayed next to
  # the "Connections" link in the menu. If there are no
  # connections then returns zero as a string object.
  def connection_requests
    begin
      frm.link(:class=>/icon connections/).span(:class=>"new-items-count").text
    rescue
      return "0"
    end
  end

  element(:say_something) { |b| b.frm.text_field(:id=>"id1") }
  action(:say_it) { |b| b.frm.button(:value=>"Say it").click }
    # Basic Information
  element(:nickname) { |b| b.frm.text_field(:name=>"nicknameContainer:nickname") }
    # Contact Information
  element(:email) { |b| b.frm.text_field(:name=>"emailContainer:email") }
  element(:home_page) { |b| b.frm.text_field(:name=>"homepageContainer:homepage") }
  element(:work_phone) { |b| b.frm.text_field(:name=>"workphoneContainer:workphone") }
  element(:home_phone) { |b| b.frm.text_field(:name=>"homephoneContainer:homephone") }
  element(:mobile_phone) { |b| b.frm.text_field(:name=>"mobilephoneContainer:mobilephone") }
  element(:facsimile) { |b| b.frm.text_field(:name=>"facsimileContainer:facsimile") }
  # Someday Staff Info fields should go here...

    # Student Information
  element(:degree_course) { |b| b.frm.text_field(:name=>"courseContainer:course") }
  element(:subjects) { |b| b.frm.text_field(:name=>"subjectsContainer:subjects") }
    # Social Networking

    # Personal Information
  element(:favorite_books) { |b| b.frm.text_field(:name=>"booksContainer:favouriteBooks") }
  element(:favorite_tv_shows) { |b| b.frm.text_field(:name=>"tvContainer:favouriteTvShows") }
  element(:favorite_movies) { |b| b.frm.text_field(:name=>"moviesContainer:favouriteMovies") }
  element(:favorite_quotes) { |b| b.frm.text_field(:name=>"quotesContainer:favouriteQuotes") }

end

#
class Profile2Preferences < BasePage

  frame_element
  include Profile2Nav

end

class Profile2Privacy < BasePage

  frame_element
  include Profile2Nav

  element(:profile_image) { |b| b.frm.select(:name=>"profileImageContainer:profileImage") }
  element(:basic_info) { |b| b.frm.select(:name=>"basicInfoContainer:basicInfo") }
  element(:contact_info) { |b| b.frm.select(:name=>"contactInfoContainer:contactInfo") }
  element(:staff_info) { |b| b.frm.select(:name=>"staffInfoContainer:staffInfo") }
  element(:student_info) { |b| b.frm.select(:name=>"studentInfoContainer:studentInfo") }
  element(:social_info) { |b| b.frm.select(:name=>"socialNetworkingInfoContainer:socialNetworkingInfo") }
  element(:personal_info) { |b| b.frm.select(:name=>"personalInfoContainer:personalInfo") }
  element(:view_connections) { |b| b.frm.select(:name=>"myFriendsContainer:myFriends") }
  element(:see_status) { |b| b.frm.select(:name=>"myStatusContainer:myStatus") }
  element(:view_pictures) { |b| b.frm.select(:name=>"myPicturesContainer:myPictures") }
  element(:send_messages) { |b| b.frm.select(:name=>"messagesContainer:messages") }
  element(:see_kudos_rating) { |b| b.frm.select(:name=>"myKudosContainer:myKudos") }
  element(:show_birth_year) { |b| b.frm.checkbox(:name=>"birthYearContainer:birthYear") }
  action(:save_settings) { |b| b.frm.button(:value=>"Save settings").click }

end

class Profile2Search < BasePage

  frame_element
  include Profile2Nav
  def search_by_name_or_email
    frm.button(:value=>"Search by name or email").click
    sleep 0.5
    Profile2Search.new(@browser)
  end

  def search_by_common_interest
    frm.button(:value=>"Search by common interest").click
    sleep 0.5
    Profile2Search.new(@browser)
  end

  def add_as_connection(name)
    frm.div(:class=>"search-result", :text=>/#{Regexp.escape(name)}/).link(:class=>"icon connection-add").click
    frm.div(:class=>"modalWindowButtons").wait_until_present
    frm.div(:class=>"modalWindowButtons").button(:value=>"Add connection").click
    frm.div(:class=>"modalWindowButtons").wait_while_present
    sleep 0.5
    Profile2Search.new @browser
  end

  def view(name)
    frm.link(:text=>name).click
    Profile2View.new(@browser)
  end

  # Returns an array containing strings of the names of the users returned
  # in the search.
  def results
    results = []
    frm.div(:class=>"portletBody").spans.each do |span|
      if span.class_name == "search-result-info-name"
        results << span.text
      end
    end
    return results
  end

  def clear_results
    frm.button(:value=>"Clear results").click
    Profile2Search.new(@browser)
  end

  element(:persons_name_or_email) { |b| b.frm.text_field(:name=>"searchName") }
  element(:common_interest) { |b| b.frm.text_field(:name=>"searchInterest") }

end

class Profile2Connections < BasePage

  frame_element
  include Profile2Nav
  def confirm_request(name)
    frm.div(:class=>"connection", :text=>name).link(:title=>"Confirm connection request").click
    frm.div(:class=>"modalWindowButtons").wait_until_present
    frm.div(:class=>"modalWindowButtons").button(:value=>"Confirm connection request").click
    frm.div(:class=>"modalWindowButtons").wait_while_present
    sleep 0.5
    Profile2Connections.new @browser
  end

  # Returns an array containing the names of the connected users.
  def connections
    results = []
    frm.div(:class=>"portletBody").spans.each do |span|
      if span.class_name == "connection-info-name"
        results << span.text
      end
    end
    return results
  end

end

class Profile2View < BasePage

  frame_element
  include Profile2Nav
  #
  def connection
    frm.div(:class=>"leftPanel").span(:class=>/instruction icon/).text
  end

  #
  def basic_information
    hash = {}
    begin
      frm.div(:class=>"mainSection", :text=>/Basic Information/).table(:class=>"profileContent").rows.each do |row|
        hash.store(row[0].text, row[1].text)
      end
    rescue Watir::Exception::UnknownObjectException

    end
    return hash
  end

  #
  def contact_information
    hash = {}
    begin
      frm.div(:class=>"mainSection", :text=>/Contact Information/).table(:class=>"profileContent").rows.each do |row|
        hash.store(row[0].text, row[1].text)
      end
    rescue Watir::Exception::UnknownObjectException

    end
    return hash
  end

  #
  def staff_information
    hash = {}
    begin
      frm.div(:class=>"mainSection", :text=>/Staff Information/).table(:class=>"profileContent").rows.each do |row|
        hash.store(row[0].text, row[1].text)
      end
    rescue Watir::Exception::UnknownObjectException

    end
    return hash
  end

  #
  def student_information
    hash = {}
    begin
      frm.div(:class=>"mainSection", :text=>/Student Information/).table(:class=>"profileContent").rows.each do |row|
        hash.store(row[0].text, row[1].text)
      end
    rescue Watir::Exception::UnknownObjectException

    end
    return hash
  end

  #
  def personal_information
    hash = {}
    begin
      frm.div(:class=>"mainSection", :text=>/Personal Information/).table(:class=>"profileContent").rows.each do |row|
        hash.store(row[0].text, row[1].text)
      end
    rescue Watir::Exception::UnknownObjectException

    end
    return hash
  end
end