class SiteObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :name, :id, :subject, :course, :section, :term, :authorizer,
    :web_content_source, :email, :joiner_role, :creation_date, :web_content_title,
    :description, :short_description, :site_contact_name, :site_contact_email

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
      :description => random_alphanums(30),
      :short_description => random_alphanums,
      :site_contact_name => random_alphanums(5)+" "+random_alphanums(8)
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
    @site_contact_name=options[:site_contact_name]
    @site_contact_email=options[:site_contact_email]
  end

  def create
    my_workspace unless @browser.title=~/My Workspace/
    site_setup unless @browser.title=~/Site Setup/
    on_page SiteSetup do |page|
      page.new
    end
    on SiteType do |page|
      # Select the Course Site radio button
      page.course_site.set
      # Store the selected term value for use later
      @term = page.academic_term.value

      page.continue
    end
    on CourseSectionInfo do |page|
      # Fill in those fields, storing the entered values for later verification steps
      page.subject.set @subject

      page.course.set @course

      page.section.set @section

      # Store site name for ease of coding and readability later
      @name = "#{@subject} #{@course} #{@section} #{@term}"
      # Add a valid instructor id
      page.authorizers_username.set @authorizer

      # Click continue button
      page.continue
    end
    on CourseSiteInfo do |page|
      page.short_description.set @short_description
      page.site_contact_name.set @site_contact_name
      page.site_contact_email.set @site_contact_email
      page.enter_source_text page.editor, @description

      # Click Continue
      page.continue
    end
    on EditSiteTools do |page|
      #Check All Tools
      page.all_tools.set
      page.continue
    end
    on AddMultipleTools do |add_tools|
      add_tools.site_email_address.set @email
      add_tools.web_content_title.set @web_content_title
      add_tools.web_content_source.set @web_content_source

      add_tools.continue
    end
    on SiteAccess do |access|
      access.allow.set
      access.joiner_role.select @joiner_role
      access.continue
    end
    on ConfirmSiteSetup do |review|
      review.request_site
    end

    # Create a string that will match the new Site's "creation date" string
    @creation_date = make_date(Time.now)

    on SiteSetup do |site_setup|
      site_setup.search(Regexp.escape(@subject))

      # Get the site id for storage
      @browser.frame(:class=>"portletMainIframe").link(:href=>/xsl-portal.site/, :index=>0).href =~ /(?<=\/site\/).+/
      @id = $~.to_s
    end
  end

  def create_and_reuse_site(site_name)
    my_workspace unless @browser.title=~/My Workspace/
    site_setup unless @browser.title=~/Site Setup/
    on_page SiteSetup do |page|
      page.new
    end
    on SiteType do |site_type|

      # Select the Course Site radio button

      site_type.course_site.set

      # Store the selected term value for use later
      @term = site_type.academic_term.value

      # Click continue
      site_type.continue
    end
    on CourseSectionInfo do |course_section|
      # Fill in those fields, storing the entered values for later verification steps
      course_section.subject.set @subject

      course_section.course.set @course

      course_section.section.set @section

      # Store site name for ease of coding and readability later
      @name = "#{@subject} #{@course} #{@section} #{@term}"

      # Add a valid instructor id
      course_section.authorizers_username.set @authorizer

      # Click continue button
      course_section.continue
    end
    on CourseSiteInfo do |course_site|
      course_site.enter_source_text course_site.editor, @description
      course_site.short_description.set @short_description
      # Click Continue
      course_site.continue
    end
    on EditSiteTools do |course_tools|
      #Check All Tools
      course_tools.all_tools.set
      course_tools.yes.set
      course_tools.import_sites.select site_name
      course_tools.continue
    end
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
      page.site_email_address.set @email
      page.web_content_title.set @web_content_title
      page.web_content_source.set @web_content_source
      page.continue
    end
    on_page SiteAccess do |page|
      page.allow.set
      page.joiner_role.select @joiner_role
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