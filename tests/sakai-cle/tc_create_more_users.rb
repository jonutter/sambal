# 
# == Synopsis
#
# This case sets up users in the test site.
#
# Author: Abe Heward (aheward@rSmart.com)
gem "test-unit"
require "test/unit"
require 'sakai-cle-test-api'
require 'yaml'

class CreateUsers < Test::Unit::TestCase

  include Utilities
  
  def setup
    
    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @directory = YAML.load_file("directory.yml")
    @sakai = SakaiCLE.new(@config['browser'], @config['url'])
    @browser = @sakai.browser
    @user_name = @directory['admin']['username']
    @password = @directory['admin']['password']
    @site_name = @directory["site1"]["name"]
    
  end
  
  def teardown
    @browser.close
  end
  
  def test_create_more_users
 
    # Log in to Sakai
    workspace = @sakai.page.login(@user_name, @password)
    
    # Go to Users page in Sakai
    users_page = workspace.users
    
    # This is for storing user ids for adding to the site later
    @ids = []
    
    # This is for storing hashes of the user info...
    @participants = []
    
    # Add each user to the workspace
    0.upto(15) do |x|
      
      # Define user info...
      @participants[x] = { 
      :id => random_nicelink,
      :first_name => random_alphanums,
      :last_name => random_alphanums,
      :email => "#{random_alphanums}@rsmart.com",
      :password => random_string(20)
      }
      create = users_page.new_user
      create.user_id=@participants[x][:id]
      create.first_name=@participants[x][:first_name]
      create.last_name=@participants[x][:last_name]
      create.email=@participants[x][:email]
      create.create_new_password=@participants[x][:password]
      create.verify_new_password=@participants[x][:password]
      create.type="registered"
      
      users_page = create.save_details
      
      users_page.search_field=@participants[x][:id]
      users_page.search_button
      
      # TEST CASE: User appears in search results
      assert_equal "#{@participants[x][:last_name]}, #{@participants[x][:first_name]}", users_page.name(@participants[x][:id])
      assert_equal "#{@participants[x][:email]}", users_page.email(@participants[x][:id])
      
      @ids << @participants[x][:id]
      
    end
    
    home = users_page.open_my_site_by_name @site_name
    
    site_editor = home.site_editor
    
    add_participants = site_editor.add_participants
    add_participants.official_participants=@ids.join("\n")
    
    role = add_participants.continue
    role.select_student
    
    email = role.continue
    confirm = email.continue
    
    # TEST CASE: Verify confirmation page contains expected info
    0.upto(15) do |x|
      assert_equal @participants[x][:id].downcase, confirm.id(@participants[x][:last_name])
      assert_equal "Student", confirm.role(@participants[x][:last_name])
    end
    
  end
  
end
