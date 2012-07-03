#!/usr/bin/env ruby
# coding: UTF-8
#
# == Synopsis
#
# Tests the My Memberships page for basic UI functionality.
#
# == Prerequisites:
#
# See lines 28-35 for required user information
#
# Author: Abe Heward (aheward@rSmart.com)
require 'sakai-oae-test-api'
require 'yaml'

describe "Test" do

  include Utilities

  let(:memberships) { MyMemberships.new @browser }

  before :all do

    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @sakai = SakaiOAE.new(@config['browser'], @config['url'])
    @directory = YAML.load_file("directory.yml")
    @browser = @sakai.browser
    # Test user information from directory.yml...


  end

  it "Test" do
    dash = @sakai.page.login("admin", "admin")

    memberships = dash.my_memberships
    course = memberships.open_course "dfhsdtnstn"
    funk = course.open_document "funk"
    funk.edit_page

    sleep 4

    funk.add_file_list
    funk.view_more_widgets
    funk.insert_video.drag_and_drop_on(funk.content_row)

  end

end
