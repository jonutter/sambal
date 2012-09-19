# This class consolidates the code that can be shared among all the
# File Upload and Attachment pages.
#
# Not every method in this class will be appropriate for every attachment page.
class AddFiles < BasePage

  frame_element

  element(:files_table) { |b| b.frm.table(:class=>/listHier lines/) }

  # Returns an array of the displayed folder names.
  def folder_names
    names = []
    files_table.rows.each do |row|
      next if row.td(:class=>"specialLink").exist? == false
      next if row.td(:class=>"specialLink").link(:title=>"Folder").exist? == false
      names << row.td(:class=>"specialLink").link(:title=>"Folder").text
    end
    names
  end

  # Returns an array of the file names currently listed
  # on the page.
  #
  # It excludes folder names.
  def file_names
    names = []
    files_table.rows.each do |row|
      next if row.td(:class=>"specialLink").exist? == false
      next if row.td(:class=>"specialLink").link(:title=>"Folder").exist?
      names << row.td(:class=>"specialLink").link(:href=>/access.content/, :index=>1).text
    end
    names
  end

  # Clicks the Select button next to the specified file.
  def select_file(filename)
    files_table.row(:text, /#{Regexp.escape(filename)}/).link(:text=>"Select").click
  end

  # Clicks the Remove button.
  action(:remove) { |b| b.frm.button(:value=>"Remove").click }

  # Clicks the remove link for the specified item in the attachment list.
  def remove_item(file_name)
    files_table.row(:text=>/#{Regexp.escape(file_name)}/).link(:href=>/doRemoveitem/).click
  end

  # Clicks the Move button.
  action(:move) { |b| b.frm.button(:value=>"Move").click }

  # Clicks the Show Other Sites link.
  action(:show_other_sites) { |b| b.frm.link(:text=>"Show other sites").click }

  def href(item)
    frm.link(:text=>item).href
  end

  # Clicks on the specified folder image, which
  # will open the folder tree and remain on the page.
  def open_folder(foldername)
    files_table.row(:text=>/#{Regexp.escape(foldername)}/).link(:title=>"Open this folder").click
  end

  # Clicks on the specified folder name, which should open
  # the folder contents on a refreshed page.
  def go_to_folder(foldername)
    frm.link(:text=>foldername).click
  end

  # Sets the URL field to the specified value.
  def url=(url_string)
    frm.text_field(:id=>"url").set(url_string)
  end

  # Clicks the Add button next to the URL field.
  action(:add) { |b| b.frm.button(:value=>"Add").click }

  # Gets the value of the access level cell for the specified
  # file.
  def access_level(filename)
    files_table.row(:text=>/#{Regexp.escape(filename)}/)[6].text
  end

  def edit_details(name)
    files_table.row(:text=>/#{Regexp.escape(name)}/).li(:text=>/Action/, :class=>"menuOpen").fire_event("onclick")
    files_table.row(:text=>/#{Regexp.escape(name)}/).link(:text=>"Edit Details").click
  end

  # Clicks the Create Folders menu item in the
  # Add menu of the specified folder.
  def create_subfolders_in(folder_name)
    open_add_menu(folder_name)
    files_table.row(:text=>/#{Regexp.escape(folder_name)}/).link(:text=>"Create Folders").click
  end

  def create_html_page_in(folder_name)
    open_add_menu(folder_name)
    files_table.row(:text=>/#{Regexp.escape(folder_name)}/).link(:text=>"Create HTML Page").click
  end

  element(:upload_file_field) { |b| b.frm.file_field(:id=>"upload") }

  # Enters the specified file into the file field name (assuming it's in the
  # data/sakai-cle-test-api folder or a subfolder therein)
  #
  def upload_file(filename, filepath="")
    upload_file_field.set(filepath + filename)
    if frm.div(:class=>"alertMessage").exist?
      sleep 2
      upload_file(filename)
    end
  end

  # Enters the specified file into the file field name (assuming it's in the
  # data/sakai-cle-test-api folder or a subfolder therein)
  #
  # Use this method ONLY for instances where there's a file field on the page
  # with an "upload" id.
  def upload_local_file(filename, filepath="")
    upload_file_field.set(filepath + filename)
    if frm.div(:class=>"alertMessage").exist?
      sleep 2
      upload_local_file(filename)
    end
  end

  # Clicks the Add Menu for the specified
  # folder, then selects the Upload Files
  # command in the menu that appears.
  def upload_file_to_folder(folder_name)
    upload_files_to_folder(folder_name)
  end

  # Clicks the Add Menu for the specified
  # folder, then selects the Upload Files
  # command in the menu that appears.
  def upload_files_to_folder(folder_name)
    if frm.li(:text=>/A/, :class=>"menuOpen").exist?
      files_table.row(:text=>/#{Regexp.escape(folder_name)}/).li(:text=>/A/, :class=>"menuOpen").fire_event("onclick")
    else
      files_table.row(:text=>/#{Regexp.escape(folder_name)}/).link(:text=>"Start Add Menu").fire_event("onfocus")
    end
    files_table.row(:text=>/#{Regexp.escape(folder_name)}/).link(:text=>"Upload Files").click
  end

  # Clicks the "Attach a copy" link for the specified
  # file, then reinstantiates the Class.
  # If an alert box appears, the method will call itself again.
  # Note that this can lead to an infinite loop. Will need to fix later.
  def attach_a_copy(file_name)
    files_table.row(:text=>/#{Regexp.escape(file_name)}/).link(:href=>/doAttachitem/).click
    if frm.div(:class=>"alertMessage").exist?
      sleep 1
      attach_a_copy(file_name) # TODO - This can loop infinitely
    end
  end

  # Takes the specified array object containing pointers
  # to local file resources, then uploads those files to
  # the folder specified, checks if they all uploaded properly and
  # if not, re-tries the ones that failed the first time.
  #
  # Finally, it re-instantiates the appropriate page class.
  # Note that it expects all files to be located in the same folder (can be in subfolders of that folder).
  def upload_multiple_files_to_folder(folder, file_array, file_path="")

    upload = upload_files_to_folder folder

    file_array.each do |file|
      upload.file_to_upload(file, file_path)
      upload.add_another_file
    end

    resources = upload.upload_files_now

    file_array.each do |file|
      file =~ /(?<=\/).+/
      # puts $~.to_s # For debugging purposes
      unless resources.file_names.include?($~.to_s)
        upload_files = resources.upload_files_to_folder(folder)
        upload_files.file_to_upload(file, file_path)
        upload_files.upload_files_now
      end
    end
  end

  # Clicks the Continue button
  def continue
    frm.div(:class=>"highlightPanel").span(:id=>"submitnotifxxx").wait_while_present
    frm.button(:value=>"Continue").click
  end

  def open_add_menu(folder_name)
    files_table.row(:text=>/#{Regexp.escape(folder_name)}/).link(:text=>"Start Add Menu").fire_event("onfocus")
  end

end