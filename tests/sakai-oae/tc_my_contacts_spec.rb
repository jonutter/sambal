#!/usr/bin/env ruby
# coding: UTF-8
# 
# == Synopsis
#
# Tests Inviting, Adding, and Removing Contacts.
#
# == Prerequisites:
#
# Requires the existence of 4 test users who do not already have each other in
# their contact lists. User 1 should not have any contacts at all.
# 
# Author: Abe Heward (aheward@rSmart.com)
require 'sakai-oae-test-api'
require 'yaml'

describe "My Contacts" do
  
  include Utilities

  before :all do
    
    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @sakai = SakaiOAE.new(@config['browser'], @config['url'])
    @directory = YAML.load_file("directory.yml")
    @browser = @sakai.browser
    # Test user information from directory.yml...
    @user1 = @directory['person1']['id']
    @pass1 = @directory['person1']['password']
    @user1_name = "#{@directory['person1']['firstname']} #{@directory['person1']['lastname']}"
    @user2 = @directory['person2']['id']
    @pass2 = @directory['person2']['password']
    @user2_name = "#{@directory['person2']['firstname']} #{@directory['person2']['lastname']}"
    @user3 = @directory['person5']['id']
    @pass3 = @directory['person5']['password']
    @user3_name = "#{@directory['person5']['firstname']} #{@directory['person5']['lastname']}"
    @user4 = @directory['person6']['id']
    @pass4 = @directory['person6']['password']
    @user4_name = "#{@directory['person6']['firstname']} #{@directory['person6']['lastname']}"
    @user5 = @directory['person7']['id']
    @pass5 = @directory['person7']['password']
    @user5_name = "#{@directory['person7']['firstname']} #{@directory['person7']['lastname']}"
    
    @sakai = SakaiOAE.new(@browser)
    
    # Test case variables...
    @invite_subject = "#{@user1_name} has invited you to become a connection"
    
  end

  it "'Find and add people' is present when expected" do
    dash = @sakai.page.login(@user1, @pass1)
    my_contacts = dash.my_contacts
    search = my_contacts.find_and_add_people
    search.search_for=@user2_name
    search.add_contact @user2_name
    search.invite
    
    search.search_for=@user3_name
    search.add_contact @user3_name
    search.invite

    search.search_for=@user5_name
    search.add_contact @user5_name
    search.invite
  end

  it "'Add' button changes to 'invitation sent'" do
    dash = @sakai.page.login(@user1, @pass1)
    my_contacts = dash.my_contacts
    search = my_contacts.find_and_add_people
    search.search_for=@user4_name
    
    # Invite from profile page...
    profile = search.view_profile @user4_name
    profile.add_to_contacts
    profile.invite
    
    # TEST CASE: The "Add" button now says the invitation
    # has been sent
    profile.invitation_sent_button_element.should be_visible
    
    search = profile.explore_people

    search.search_for=@user2_name
    
    # TEST CASE: The "Add contact" button is not
    # present for people already invited to connect
    search.addable?(@user2_name).should_not == true
  end

  it "verify pending invitation" do
    dash = @sakai.page.login(@user2, @pass2)
    
    my_contacts = dash.my_contacts

    # TEST CASE: Verify there is a pending invitation from
    # the expected person
    my_contacts.pending_invites.should include @user1_name
    
    my_contacts.accept_connection @user1_name

    # TEST CASE: Verify the user now appears in the My contacts list
    my_contacts.contacts.should include @user1_name
    
    # TEST CASE: Verify the "Pending contacts" heading is gone
    my_contacts.pending_contacts.should_not be_present

  end

  it "Connection request delivered" do
    dash = @sakai.page.login(@user3, @pass3)
    my_messages = dash.my_messages
    
    my_messages.invitations
   
    # TEST CASE: Mailbox contains a connection request from the expected user
    my_messages.message_subjects.should include @invite_subject
    
    my_messages.read_message @invite_subject
    
    my_messages.ignore_invitation
    
    my_contacts = my_messages.my_contacts
    
    # TEST CASE: After user rejects request, the pending request is gone
    my_contacts.pending_contacts.should_not exist
    
    # TEST CASE: Page includes message that the user does not have any contacts, yet.
    @browser.text.should include "You don't have any contacts yet."
  end

  it "Invitation can be accepted" do
    dash = @sakai.page.login(@user4, @pass4)
    
    my_contacts = dash.my_contacts
    
    profile = my_contacts.view_profile @user1_name
    
    # TEST CASE: Profile page has an "Accept invitation" button
    lambda { profile.accept_invitation }.should_not raise_error
    
    my_contacts = profile.my_contacts
    
    # TEST CASE: User now appears in contacts list
    my_contacts.contacts.should include @user1_name
  end

  it "The contacts list contains expected items" do
    dash = @sakai.page.login(@user1, @pass1)
    
    my_contacts = dash.my_contacts

    my_contacts.contacts.should include @user2_name
    my_contacts.contacts.should include @user4_name
    my_contacts.contacts.should_not include @user3_name
    
  end

  it "Contacts can be removed" do
    dash = @sakai.page.login(@user5, @pass5)
    
    my_contacts = dash.my_contacts
    
    profile = my_contacts.view_profile @user1_name

    profile.accept_invitation
    
    @sakai.logout
    
    dash = @sakai.page.login(@user1, @pass1)
    
    my_contacts = dash.my_contacts
    
    # TEST CASE: Contacts can be removed from My Contacts
    my_contacts.remove @user5_name
    my_contacts.remove_contact
    
    # TEST CASE: Contacts list is as expected after removal
    my_contacts.contacts.should include @user4_name
    my_contacts.contacts.should_not include @user5_name
  end
  
  it "Removed user no longer sees remover in their contact list" do
    dash = @sakai.page.login(@user5, @pass5)
    
    my_contacts = dash.my_contacts
    
    # TEST CASE: User 1 is automatically removed from User 2's list
    my_contacts.contacts.should_not include @user1_name
  end
  
  after :each do
    @sakai.logout
  end
  
  after :all do
    # Close the browser window
    @browser.close
  end

end
