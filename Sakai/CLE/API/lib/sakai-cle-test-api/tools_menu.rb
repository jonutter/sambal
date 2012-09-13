# ToolsMenu contains all possible links that could
# be found in the menu along the left side of the Sakai pages.
#
# This includes both the Administration Workspace and the
# Menus that appear when in the context of a particular Site.
module ToolsMenu

  # Opens "My Sites" and then clicks on the matching
  # Site name. Shortens the name used for search so
  # that truncated names are not a problem.
  # Should be followed by the Home class.
  #
  # Will error out if there are not matching links.
  def open_my_site_by_name(name)
    truncated_name = name[0..19]
    @browser.link(:text, "My Sites").click
    @browser.link(:text, /#{Regexp.escape(truncated_name)}/).click
  end

  # Clicks the "Account" link in the Adminstration Workspace
  # Should be followed by the UserAccount class.
  #
  # Throws an error if the link is not present.
  action(:account) { |b| b.link(:text=>"Account").click }

  # Clicks the "Aliases" link in the Administration Workspace
  # menu, then should be followed by the Aliases class.
  action(:aliases) { |b| b.link(:text=>"Aliases").click }

  # Clicks the link for the Administration Workspace, then
  # should be followed by the MyWorkspace class.
  action(:administration_workspace) { |b| b.link(:text, "Administration Workspace").click }

  # Clicks the Announcements link then instantiates
  # the Announcements class.
  action(:announcements) { |b| b.link(:class=>'icon-sakai-announcements').click }

  # Clicks the Assignments link, then instantiates
  # the Assignments class.
  action(:assignments) { |b| b.link(:class=>"icon-sakai-assignment-grades").click }

  # BasicLTI class
  action(:basic_lti) { |b| b.link(:class=>"icon-sakai-basiclti").click }

  # Blogs class
  action(:blogs) { |b| b.link(:class=>"icon-sakai-blogwow").click }

  # Clicks the Blogger link in the Site menu and
  # instantiates the Blogger Class.
  action(:blogger) { |b| b.link(:class=>"icon-blogger").click }

  # Clicks the Calendar link, then instantiates
  # the Calendar class.
  action(:calendar) { |b| b.link(:text=>"Calendar").click }

  action(:certification) { |b| b.link(:text=>"Certification").click }

  # ChatRoom class
  action(:chat_room) { |b| b.link(:class=>"icon-sakai-chat").click }

  action(:configuration_viewer) { |b| b.link(:text=>"Configuration Viewer").click }
  action(:customizer) { |b| b.link(:text=>"Customizer").click }

  # JForum page class.
  action(:discussion_forums) {  |b| b.link(:class=>"icon-sakai-jforum-tool").click }

  # DropBox class
  action(:drop_box) { |b| b.link(:class=>"icon-sakai-dropbox").click }

  action(:email) { |b| b.link(:text=>"Email").click }

  # Email Archive class
  action(:email_archive) { |b| b.link(:class=>"icon-sakai-mailbox").click }

  action(:email_template_administration) { |b| b.link(:text=>"Email Template Administration").click }

  # EvaluationSystem class
  action(:evaluation_system) { |b| b.link(:class=>"icon-sakai-rsf-evaluation").click }

  # Feedback class
  action(:feedback) { |b| b.link(:class=>"icon-sakai-postem").click }

  # Forms class
  action(:forms) { |b| b.link(:text=>"Forms", :class=>"icon-sakai-metaobj").click }

  # Forums class.
  action(:forums) { |b| b.link(:text=>"Forums").click }

  # Glossary Class.
  action(:glossary) { |b| b.link(:text=>"Glossary").click }

  # Gradebook Class.
  action(:gradebook) { |b| b.link(:text=>"Gradebook").click }

  # Gradebook2 class
  action(:gradebook2) { |b| b.link(:text=>"Gradebook2").click }

  action(:help) { |b| b.link(:text=>"Help").click }

  # Home class--unless the target page happens to be
  # My Workspace, in which case the MyWorkspace
  # page should be used.
  action(:home) { |b| b.link(:text, "Home").click }

  # Job Scheduler class.
  action(:job_scheduler) { |b| b.link(:text=>"Job Scheduler").click }

  # Lessons class
  action(:lessons) { |b| b.link(:text=>"Lessons").click }

  action(:lesson_builder) { |b| b.link(:text=>"Lesson Builder").click }
  action(:link_tool) { |b| b.link(:text=>"Link Tool").click }
  action(:live_virtual_classroom) { |b| b.link(:text=>"Live Virtual Classroom").click }

  # Matrices Class
  action(:matrices) { |b| b.link(:text=>"Matrices").click }

  # MediaGallery class
  action(:media_gallery) { |b| b.link(:class=>"icon-sakai-kaltura").click }

  action(:membership, :text=>"Membership")
  action(:memory, :text=>"Memory")

  # Messages class.
  action(:messages) { |b| b.link(:text=>"Messages").click }

  action(:my_sites) { |b| b.link(:text=>"My Sites").click }

  # MyWorkspace Class.
  action(:my_workspace) { |b| b.link(:text=>"My Workspace").click }

  # News
  action(:news) { |b| b.link(:class=>"icon-sakai-news").click }

  action(:online) { |b| b.link(:text=>"On-Line").click }
  action(:oauth_providers) { |b| b.link(:text=>"Oauth Providers").click }
  action(:oauth_tokens) { |b| b.link(:text=>"Oauth Tokens").click }
  action(:openSyllabus) { |b| b.link(:text=>"OpenSyllabus").click }

  # Podcasts
  action(:podcasts) { |b| b.link(:class=>"icon-sakai-podcasts").click }

  # Polls class
  action(:polls) { |b| b.link(:class=>"icon-sakai-poll").click }

  # Portfolios class
  action(:portfolios) { |b| b.link(:class=>"icon-osp-presentation").click }

  # PortfolioTemplates
  action(:portfolio_templates) { |b| b.link(:text=>"Portfolio Templates").click }

  action(:preferences) { |b| b.link(:text=>"Preferences").click }

  action(:profile) { |b| b.link(:text=>"Profile").click }

  # Profile2 class
  action(:profile2) { |b| b.link(:class=>"icon-sakai-profile2").click }

  action(:realms) { |b| b.link(:text=>"Realms").click }

  # Resources class.
  action(:resources) { |b| b.link(:text, "Resources").click }

  # Roster
  action(:roster) { |b| b.link(:class=>"icon-sakai-site-roster").click }

  action(:rsmart_support) { |b| b.link(:text=>"rSmart Support").click }

  # Because "Search" is used in many pages,
  # The Search button found in the Site Management
  # Menu must be given the more explicit name
  action(:site_management_search) { |b| b.link(:class=>"icon-sakai-search").click }

  # Sections
  action(:sections) { |b| b.link(:class=>"icon-sakai-sections").click }

  action(:site_archive) { |b| b.link(:text=>"Site Archive").click }

  # SiteEditor class.
  action(:site_editor) { |b| b.link(:text=>"Site Editor").click }

  # SiteSetup class.
  action(:site_setup) { |b| b.link(:text=>"Site Setup").click }

  action(:site_statistics) { |b| b.link(:text=>"Site Statistics").click }

  # Sites class.
  action(:sites) { |b| b.link(:class=>"icon-sakai-sites").click }

  action(:skin_manager) { |b| b.link(:text=>"Skin Manager").click }
  action(:super_user) { |b| b.link(:text=>"Super User").click }

  # Styles
  action(:styles) { |b| b.link(:text=>"Styles").click }

  # Syllabus class.
  action(:syllabus) { |b| b.link(:text=>"Syllabus").click }

  #AssessmentsList class OR the TakeAssessmentList for students
  action(:tests_and_quizzes) { |b| b.link(:text=>"Tests & Quizzes").click }
  alias assessments tests_and_quizzes

  # UserMembership
  action(:user_membership) { |b| b.link(:class=>"icon-sakai-usermembership").click }

  # Users
  action(:users) { |b| b.link(:class=>"icon-sakai-users").click }

  # WebContent
  action(:web_content) { |b| b.link(:class=>"icon-sakai-iframe").click }

  # Wikis
  action(:wiki) { |b| b.link(:class=>"icon-sakai-rwiki").click }

  # The Page Reset button, found on all Site pages
  action(:reset) { |b| b.link(:href=>/tool-reset/).click }

  # Login class.
  action(:logout) { |b| b.link(:text, "Logout").click }
  alias log_out logout
  alias sign_out logout

end
