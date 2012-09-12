class SiteObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :name, :id, :subject, :course, :section, :term, :authorizer,
    :web_content_source, :email, :joiner_role, :creation_date, :web_content_title,
    :description, :short_description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :subject => random_alphanums(8),
      :course => random_alphanums(8),
      :section => random_alphanums(8),
      :authorizer => "admin",
      :web_content_title => random_alphanums(15),
      :web_content_source => "http://www.rsmart.com",
      :email=>random_nicelink(32),
      :joiner_role => "Student",
      :description => random_multiline,
      :short_description => random_alphanums
    }
    options = defaults.merge(opts)

    @subject=options[:subject]
    @course=options[:course]
    @section=options[:section]
    @authorizer=options[:authorizer]
    @web_content_source=options[:web_content_source]
    @email=options[:email]
    @joiner_role=options[:joiner_role]
    @web_content_title=options[:web_content_title]
    @description=options[:description]
    @short_description=options[:short_description]
  end

  def create
    workspace = my_workspace
    #Go to Site Setup page
    if @browser.title=~/Site Setup/
      on_page SiteSetup do |page|
        page.new
      end
      site_type = SiteType.new @browser
    else
      site_setup = workspace.site_setup
      site_type = site_setup.new
    end

    # Select the Course Site radio button

    site_type.select_course_site

    # Store the selected term value for use later
    @term = site_type.academic_term_element.value

    # Click continue
    course_section = site_type.continue

    # Fill in those fields, storing the entered values for later verification steps
    course_section.subject = @subject

    course_section.course = @course

    course_section.section = @section

    # Store site name for ease of coding and readability later
    @name = "#{@subject} #{@course} #{@section} #{@term}"

    # Click continue button
    course_section.continue

    # Add a valid instructor id
    course_section.authorizers_username=@authorizer

    # Click continue button
    course_site = course_section.continue

    course_site.source(course_site.editor)
    course_site.source=@description
    course_site.short_description=@short_description

    # Click Continue
    course_tools = course_site.continue

    #Check All Tools
    course_tools.check_all_tools

    course_tools.continue
    add_tools = AddMultipleTools.new @browser
    add_tools.site_email_address=@email
    add_tools.web_content_title=@web_content_title
    add_tools.web_content_source=@web_content_source

    # Click the Continue button
    # Note that I am calling this element directly rather than using its Class definition
    # because of an inexplicable ObsoleteElementError occuring in Selenium-Webdriver
    @browser.frame(:index=>0).button(:name, "Continue").click

    access = SiteAccess.new(@browser)

    access.select_allow
    access.joiner_role=@joiner_role

    review = access.continue

    site_setup = review.request_site

    # Create a string that will match the new Site's "creation date" string
    @creation_date = make_date(Time.now)

    site_setup.search(Regexp.escape(@subject))

    # Get the site id for storage
    @browser.frame(:class=>"portletMainIframe").link(:href=>/xsl-portal.site/, :index=>0).href =~ /(?<=\/site\/).+/
    @id = $~.to_s

  end

  def create_and_reuse_site(site_name)
    workspace = my_workspace

    #Go to Site Setup page
    if @browser.title=~/Site Setup/
      on_page SiteSetup do |page|
        page.new
      end
      site_type = SiteType.new @browser
    else
      site_setup = workspace.site_setup
      site_type = site_setup.new
    end

    # Select the Course Site radio button

    site_type.select_course_site
sleep 5
    # Store the selected term value for use later
    @term = site_type.academic_term_element.value

    # Click continue
    course_section = site_type.continue
sleep 5
    # Fill in those fields, storing the entered values for later verification steps
    course_section.subject = @subject

    course_section.course = @course

    course_section.section = @section

    # Store site name for ease of coding and readability later
    @name = "#{@subject} #{@course} #{@section} #{@term}"
sleep 5
    # Click continue button
    course_section.continue

    # Add a valid instructor id
    course_section.authorizers_username=@authorizer

    # Click continue button
    course_site = course_section.continue
    course_site.source(course_site.editor)
    course_site.source=@description
    course_site.short_description=@short_description
    # Click Continue
    course_tools = course_site.continue

    #Check All Tools
    course_tools.check_all_tools
    course_tools.select_yes
    course_tools.import_sites=site_name
    course_tools.continue
    on_page ReUseMaterial do |page|
      page.announcements_checkbox.set
      page.calendar_checkbox.set
      page.discussion_forums_checkbox.set
      page.forums_checkbox.set
      page.chat_room_checkbox.set
      page.polls_checkbox.set
      page.syllabus_checkbox.set
      page.lessons_checkbox.set
      page.resources_checkbox.set
      page.assignments_checkbox.set
      page.tests_and_quizzes_checkbox.set
      page.gradebook_checkbox.set
      page.gradebook2_checkbox.set
      page.wiki_checkbox.set
      page.news_checkbox.set
      page.web_content_checkbox.set
      page.site_statistics_checkbox.set
      page.continue
    end
    on_page AddMultipleTools do |page|
      page.site_email_address=@email
      page.web_content_title=@web_content_title
      page.web_content_source=@web_content_source
      page.continue
    end
    on_page SiteAccess do |page|
      page.select_allow
      page.joiner_role=@joiner_role
      page.continue
    end
    on_page ConfirmSiteSetup do |page|
      page.request_site
    end
    # Create a string that will match the new Site's "creation date" string
    @creation_date = make_date(Time.now)
    on_page SiteSetup do |page|
      page.search(Regexp.escape(@subject))
    end
    # Get the site id for storage
    @browser.frame(:class=>"portletMainIframe").link(:href=>/xsl-portal.site/, :index=>0).href =~ /(?<=\/site\/).+/
    @id = $~.to_s

  end

end