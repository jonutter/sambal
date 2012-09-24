
gem "test-unit"
require "test/unit"
require 'sakai-cle-test-api'
require 'yaml'

class TestImportSite < Test::Unit::TestCase
  
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
    @file_path = @config['data_directory']
    @source_site_string = "Links to various items in this site:\n"

  end
  
  def teardown
    # Close the browser window
    @browser.close
  end
  
  def test_import_site_materials

    # Log in to Sakai
    @sakai.page.login(@instructor, @ipassword)

    @site1 = make SiteObject, :description=>"Original Site"
    @site1.create

    @source_site_string << "Source Site ID: #{@site1.id}<br />"

    @assignment = make AssignmentObject, :site=>@site1.name, :instructions=>@source_site_string
    @assignment.create

    @source_site_string << "<br />Assignment ID: #{@assignment.id}<br />Assignment link: <a href=\"#{@assignment.link}\">#{@assignment.title}</a><br />"

    @announcement = make AnnouncementObject, :site=>@site1.name, :body=>@assignment.link
    @announcement.create

    @source_site_string << "<br />Announcement link: <a href=\"#{@announcement.link}\">#{@announcement.title}</a><br />"

    @htmlpage = make HTMLPageObject, :site=>@site1.name, :folder=>"#{@site1.name} Resources", :html=>@source_site_string
    @htmlpage.create

    @source_site_string << "<br />HTML Page: <a href=\"#{@htmlpage.url}\">#{@htmlpage.name}</a><br />"

    @file = make FileObject, :site=>@site1.name, :name=>"flower02.jpg", :source_path=>@file_path+"images/"
    @file.create

    @folder = make FolderObject, :site=>@site1.name, :parent_folder=>"#{@site1.name} Resources"
    @folder.create

    @nestedhtmlpage = make HTMLPageObject, :site=>@site1.name, :folder=>@folder.name, :html=>@source_site_string
    @nestedhtmlpage.create

    @source_site_string << "<br />Nested HTML Page: <a href=\"#{@nestedhtmlpage.url}\">#{@nestedhtmlpage.name}</a><br />"

    @assignment.edit :instructions=>@source_site_string

    @web_content1 = make WebContentObject, :title=>@htmlpage.name, :source=>@htmlpage.url, :site=>@htmlpage.site
    @web_content1.create

    @web_content2 = make WebContentObject, :title=>@nestedhtmlpage.name, :source=>@nestedhtmlpage.url, :site=>@nestedhtmlpage.site
    @web_content2.create

    @module = make ModuleObject, :site=>@site1.name
    @module.create

    @section1 = make ContentSectionObject, :site=>@site1.name, :module=>@module.title, :content_type=>"Compose content with editor",
                     :editor_content=>@source_site_string
    @section1.create

    @section2 = make ContentSectionObject, :site=>@site1.name, :module=>@module.title, :content_type=>"Upload or link to a file",
                     :file_name=>"flower01.jpg", :file_path=>@file_path+"images/"
    @section2.create

    @section3 = make ContentSectionObject, :site=>@site1.name, :module=>@module.title, :content_type=>"Link to new or existing URL resource on server",
                    :url=>@htmlpage.url, :url_title=>@htmlpage.name
    @section3.create

    @section4 = make ContentSectionObject, :site=>@site1.name, :module=>@module.title, :content_type=>"Upload or link to a file in Resources",
        :file_name=>@nestedhtmlpage.name, :file_folder=>@nestedhtmlpage.folder
    @section4.create

    @wiki = make WikiObject, :site=>@site1.name, :content=>"{image:worksite:/#{@file.name}}\n\n{worksiteinfo}\n\n{sakai-sections}"
    @wiki.create

    @site2 = make SiteObject
    @site2.create_and_reuse_site @site1.name

  end
  
end
