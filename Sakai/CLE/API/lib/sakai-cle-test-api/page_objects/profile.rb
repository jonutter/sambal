#================
# Profile Pages
#================

#
class Profile < BasePage

  frame_element

  def edit_my_profile
    frm.link(:text=>"Edit my Profile").click
    EditProfile.new(@browser)
  end

  def show_my_profile
    frm.link(:text=>"Show my Profile").click
    Profile.new @browser
  end

  def photo
    source = frm.image(:id=>"profileForm:image1").src
    return source.split("/")[-1]
  end

  def email
    frm.link(:id=>"profileForm:email").text
  end
end

#
class EditProfile < BasePage

  frame_element

  def save
    frm.button(:value=>"Save").click
    Profile.new(@browser)
  end

  def picture_file(filename, filepath="")
    frm.file_field(:name=>"editProfileForm:uploadFile.uploadId").set(filepath + filename)
  end

  element(:first_name) { |b| b.frm.text_field(:id=>"editProfileForm:first_name") }
  element(:last_name) { |b| b.frm.text_field(:id=>"editProfileForm:lname") }
  element(:nickname) { |b| b.frm.text_field(:id=>"editProfileForm:nickname") }
  element(:position) { |b| b.frm.text_field(:id=>"editProfileForm:position") }
  element(:email) { |b| b.frm.text_field(:id=>"editProfileForm:email") }
  element(:upload_new_picture) { |b| b.frm.radio(:value=>"pictureUpload") }

end