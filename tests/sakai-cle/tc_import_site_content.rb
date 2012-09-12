
gem "test-unit"
require "test/unit"
require 'sakai-cle-test-api'
require 'yaml'

class TestDuplicateSite < Test::Unit::TestCase
  
  include Utilities

  def setup
    
    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @directory = YAML.load_file("directory.yml")
    @sakai = SakaiCLE.new(@config['browser'], @config['url'])
    @browser = @sakai.browser
    # This test case uses the logins of several users
    @instructor = "admin"
    @ipassword = "admin"

    @source_site_string = "Links to various items in this site:\n"

  end
  
  def teardown
    # Close the browser window
    @browser.close
  end
  
  def test_duplicate_site

    # Log in to Sakai
    @sakai.page.login(@instructor, @ipassword)

    @site1 = make SiteObject

    @site1.create

    @source_site_string << "Source Site ID: #{@site1.id}</br>"

    @assignment = make AssignmentObject, :site=>@site1.name, :instructions=>@source_site_string
    @assignment.create

    @source_site_string << "</br>Assignment ID: #{@assignment.id}</br>Assignment link: <a href=\"#{@assignment.link}\">#{@assignment.title}</a></br>"

    @announcement = make AnnouncementObject, :site=>@site1.name, :body=>@assignment.link
    @announcement.create

    @source_site_string << "</br>Announcement link: <a href=\"#{@announcement.link}\">#{@announcement.title}</a></br>"

    @htmlpage = make HTMLPageObject, :site=>@site1.name, :folder=>"#{@site1.name} Resources", :html=>@source_site_string
    @htmlpage.create

    @source_site_string << "</br>HTML Page: <a href=\"#{@htmlpage.url}\">#{@htmlpage.name}</a></br>"

    @folder = make FolderObject, :site=>@site1, :parent_folder=>"#{@site1.name} Resources"
    @folder.create

    @nestedhtmlpage = make HTMLPageObject, :site=>@site1.name, :folder=>@folder.name, :html=>@source_site_string
    @nestedhtmlpage.create

    @source_site_string << "</br>Nested HTML Page: <a href=\"#{@nestedhtmlpage.url}\">#{@nestedhtmlpage.name}</a></br>"

    puts @source_site_string
  end
  
end
