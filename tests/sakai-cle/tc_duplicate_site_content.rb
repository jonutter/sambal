
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

    @assignment = make AssignmentObject, :site=>@site1.name
    @assignment.create

    @announcement = make AnnouncementObject, :site=>@site1.name, :body=>@assignment.link
    @announcement.create

    sleep 10
    
  end
  
end
