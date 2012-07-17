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
    @last_manager_error = "Group membership\nYou are unable to remove your membership from Another Group UY0H8Y67mn because you are the only manager"


  end

  it "Test" do
    dash = @sakai.page.login("student01", "password")
    bla = dash.my_memberships

  end

  xit "'Leave group' button removes user from the given group" do
    memberships.leave_group "Group P9J0Vd0RXX"
    memberships.yes_apply
    memberships.close_notification
    memberships.memberships.should_not include "Another Group UY0H8Y67mn"
  end

  xit "The last manager of a group is not allowed to leave it" do
    memberships.leave_group "Another Group UY0H8Y67mn"
    memberships.notification.should == @last_manager_error
  end

  xit "'Add to' button is disabled when no items are selected" do
    memberships.add_selected_button_element.should be_disabled
  end

  xit "'Message' button is disabled when no items are selected" do
    memberships.message_selected_button_element.should be_disabled
  end

  it "Clicking the 'X participants' link navigates to Group's Participants page" do
    participants = memberships.view_group_participants "Another Group UY0H8Y67mn"
    participants.search_participants_element.should be_visible
  end

end
