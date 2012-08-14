# Author: Abe Heward (aheward@rSmart.com)
gem "test-unit"
require "test/unit"
require 'sakai-cle-test-api'
require 'yaml'

class TestBlogWow < Test::Unit::TestCase

  include Utilities

  def setup
    # Get the test configuration data
    @config = YAML.load_file("config.yml")
    @directory = YAML.load_file("directory.yml")
    @sakai = SakaiCLE.new(@config['browser'], @config['url'])
    @browser = @sakai.browser
    # This is an admin user test case
    @user_name = @directory['person2']['id']
    @password = @directory['person2']['password']
    @file_path = @config['data_directory']

    @blog_title = random_alphanums(20)
    @blog_text = randome_multiline(100, 10)
  end

  def teardown
    # Close the browser window
    @browser.close
  end

  def test_blog_wow
    # Log in to Sakai
    workspace = @sakai.page.login(@user_name, @password)

    home = workspace.open_my_site_by_id(@site_id)

    blogs = home.blogs

    add_blog = blogs.add_blog_entry
    add_blog.title=@blog_title
    add_blog.blog_text=@blog_text


    sleep 20
    exit

    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//input[@name=\"title-input\"]").clear
    @driver.find_element(:xpath, "//input[@name=\"title-input\"]").send_keys "I'm a blog"
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").clear
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").send_keys "In pulvinar neque id dui! Proin luctus magna. Nulla velit. Nulla facilisi. Vivamus suscipit convallis augue. Sed eget purus. Nam consequat rutrum pede. Integer condimentum congue augue? Maecenas euismod eros lobortis diam? Suspendisse potenti. Maecenas dictum, elit at porta porttitor, mauris est dignissim mi, ut ornare nisl tortor aliquet velit. In et nulla! Aenean tempor. Maecenas dapibus iaculis pede. Aenean ante odio, pretium ornare, venenatis eu, suscipit id, pede. Cras blandit nulla quis lorem. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec quam. Morbi in nisl!"
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    @driver.find_element(:xpath, "//input[@value=\"Publish entry\"]").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog')]").should be_true }
    @driver.find_element(:link, "My blog settings").click
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").clear
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").send_keys "I am a dynamic figure, often seen scaling walls and crushing ice. I have been known to remodel train stations on my lunch breaks, making them more efficient in the area of heat retention. I translate ethnic slurs for Cuban refugees, I write award-winning operas, I manage time efficiently. Occasionally, I tread water for three days in a row."
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    @driver.find_element(:xpath, "//input[@name='command link parameters&Submitting%20control=change-settings-button&Fast%20track%20action=BlogLocator.saveAll']").click
    @driver.find_element(:link, "My blog").click
    verify { element_present?(:xpath, "//img[@alt='Default profile image']").should be_true }
    @driver.find_element(:link, "Logout").click
    # CLE-2553
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//input[@value='submit']").click
    @driver.find_element(:xpath, "//a[contains(@title,'1 2 3')]").click
    @driver.find_element(:xpath, "//a[@class='icon-sakai-blogwow']").click
    @driver.find_element(:link, "Achilles Punks").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog')]").should be_true }
    @driver.find_element(:link, "Leave a comment").click
    @driver.find_element(:xpath, "//textarea").clear
    @driver.find_element(:xpath, "//textarea").send_keys "Nulla ullamcorper adipiscing lectus. Etiam nisi ligula, ornare nec, ullamcorper ut, elementum ut, magna. Pellentesque vulputate semper nisl. Fusce diam odio, euismod quis, condimentum vitae, volutpat ut; odio. Etiam nisl massa, ornare nec, porta at, commodo vel, lectus. Aenean dictum. Cras dictum, lectus sed aliquet iaculis, nibh magna vestibulum augue, non sagittis orci lacus vitae sapien. Vestibulum nisl dolor, suscipit eu, suscipit semper, consequat ac, metus! Suspendisse convallis lectus vel quam! Ut porttitor enim non odio! Etiam interdum quam a nibh. Morbi in ligula. Nunc sit amet tortor nec pede luctus varius. Praesent tristique dolor sit amet odio. Nam convallis metus vel urna.\n\nMauris vel tellus vitae lectus mattis placerat! Nullam accumsan fermentum libero. Sed quis tellus sed nunc imperdiet ultrices. Integer luctus nulla eu nisi cursus pretium. Vestibulum condimentum. Duis ac leo. Etiam et mauris. Sed eu nulla. Proin rutrum tempus orci. Cras tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer nulla magna, sagittis et, feugiat sit amet, bibendum fringilla, tellus. Curabitur tempor amet.\n\nNulla ullamcorper adipiscing lectus. Etiam nisi ligula, ornare nec, ullamcorper ut, elementum ut, magna. Pellentesque vulputate semper nisl. Fusce diam odio, euismod quis, condimentum vitae, volutpat ut; odio. Etiam nisl massa, ornare nec, porta at, commodo vel, lectus. Aenean dictum. Cras dictum, lectus sed aliquet iaculis, nibh magna vestibulum augue, non sagittis orci lacus vitae sapien. Vestibulum nisl dolor, suscipit eu, suscipit semper, consequat ac, metus! Suspendisse convallis lectus vel quam! Ut porttitor enim non odio! Etiam interdum quam a nibh. Morbi in ligula. Nunc sit amet tortor nec pede luctus varius. Praesent tristique dolor sit amet odio. Nam convallis metus vel urna.\n\nMauris vel tellus vitae lectus mattis placerat! Nullam accumsan fermentum libero. Sed quis tellus sed nunc imperdiet ultrices. Integer luctus nulla eu nisi cursus pretium. Vestibulum condimentum. Duis ac leo. Etiam et mauris. Sed eu nulla. Proin rutrum tempus orci. Cras tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer nulla magna, sagittis et, feugiat sit amet, bibendum fringilla, tellus. Curabitur tempor amet.\n\nNulla ullamcorper adipiscing lectus. Etiam nisi ligula, ornare nec, ullamcorper ut, elementum ut, magna. Pellentesque vulputate semper nisl. Fusce diam odio, euismod quis, condimentum vitae, volutpat ut; odio. Etiam nisl massa, ornare nec, porta at, commodo vel, lectus. Aenean dictum. Cras dictum, lectus sed aliquet iaculis, nibh magna vestibulum augue, non sagittis orci lacus vitae sapien. Vestibulum nisl dolor, suscipit eu, suscipit semper, consequat ac, metus! Suspendisse convallis lectus vel quam! Ut porttitor enim non odio! Etiam interdum quam a nibh. Morbi in ligula. Nunc sit amet tortor nec pede luctus varius. Praesent tristique dolor sit amet odio. Nam convallis metus vel urna.\n\nMauris vel tellus vitae lectus mattis placerat! Nullam accumsan fermentum libero. Sed quis tellus sed nunc imperdiet ultrices. Integer luctus nulla eu nisi cursus pretium. Vestibulum condimentum. Duis ac leo. Etiam et mauris. Sed eu nulla. Proin rutrum tempus orci. Cras tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer nulla magna, sagittis et, feugiat sit amet, bibendum fringilla, tellus. Curabitur tempor amet."
    @driver.find_element(:xpath, "//input[@value=\"Publish comment\"]").click
    @driver.find_element(:link, "Add blog entry").click
    @driver.find_element(:xpath, "//input[@name=\"title-input\"]").clear
    @driver.find_element(:xpath, "//input[@name=\"title-input\"]").send_keys "I'm a blog too"
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").clear
    @driver.find_element(:xpath, "//textarea[@class='SourceField']").send_keys "In pulvinar neque id dui! Proin luctus magna. Nulla velit. Nulla facilisi. Vivamus suscipit convallis augue. Sed eget purus. Nam consequat rutrum pede. Integer condimentum congue augue? Maecenas euismod eros lobortis diam? Suspendisse potenti. Maecenas dictum, elit at porta porttitor, mauris est dignissim mi, ut ornare nisl tortor aliquet velit. In et nulla! Aenean tempor. Maecenas dapibus iaculis pede. Aenean ante odio, pretium ornare, venenatis eu, suscipit id, pede. Cras blandit nulla quis lorem. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec quam. Morbi in nisl!"
    @driver.find_element(:xpath, "//td[@class='TB_Button_Text']").click
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//input[@name='command link parameters&Submitting%20control=publish-button&Fast%20track%20action=EntryLocator.publishAll']").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog too')]").should be_true }
    @driver.find_element(:link, "Logout").click
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//input[@value='submit']").click
    @driver.find_element(:xpath, "//a[contains(@title,'1 2 3')]").click
    @driver.find_element(:xpath, "//a[@class='icon-sakai-blogwow']").click
    @driver.find_element(:link, "Achilles Punks").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog')]").should be_true }
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:link, "Logout").click
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    # ERROR: Caught exception [Error: locator strategy either id or name must be specified explicitly.]
    @driver.find_element(:xpath, "//input[@value='submit']").click
    @driver.find_element(:xpath, "//a[contains(@title,'1 2 3')]").click
    @driver.find_element(:xpath, "//a[@class='icon-sakai-blogwow']").click
    @driver.find_element(:link, "Achilles Punks").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog')]").should be_true }
    @driver.find_element(:xpath, "//img[@alt='Reset']").click
    @driver.find_element(:link, "Sandra Cheeks").click
    verify { element_present?(:xpath, "//span[contains(text(),'m a blog too')]").should be_true }
    @driver.find_element(:link, "Logout").click
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end
