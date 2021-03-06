#!/usr/bin/env ruby
# 
# == Synopsis
#
# Tests the removal and re-adding of all dashboard widgets.
#
# == Prerequisites
#
# 
# Author: Abe Heward (aheward@rSmart.com)
require 'sakai-oae-test-api'
require 'yaml'

describe "Add/Remove Dashboard Widgets" do
  
  include Utilities

  before :all do
    
    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @sakai = SakaiOAE.new(@config['browser'], @config['url'])
    @directory = YAML.load_file("directory.yml")
    @browser = @sakai.browser
    @sakai = SakaiOAE.new(@browser)
    
    # Test case variables...
    @widgets = ["My recent memberships", "My content", "Most active groups",
                "Most active content", "Most popular tags",
                "My contacts", "Account preferences", "My recent messages",
                "My recent contacts", "My memberships", "My recent content"]
    @user = @directory['admin']['username']
    @password = @directory['admin']['password']
    
  end
  
  it "All widgets can be removed" do
    # Log in to Sakai
    dashboard = @sakai.page.login(@user, @password)
    dashboard.add_widgets
    dashboard.remove_all_widgets
    dashboard = dashboard.close_add_widget
    # TEST CASE: All widgets removed
    dashboard.displayed_widgets.should == []
  end
  
  it "All widgets can be added" do
    dashboard = MyDashboard.new @browser
    @widgets.each do |widget|
      dashboard.add_widgets
      dashboard.add_widget widget
      dashboard = dashboard.close_add_widget
      # TEST CASE: Widget added
      dashboard.displayed_widgets.should include widget
    end
  end

  after :all do
    # Close the browser window
    @browser.close
  end

end
