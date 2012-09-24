# Workflows is a module containing helper navigation methods
module Workflows

  def self.menu_link name, opts={}
    define_method name.to_s do
      @browser.link(opts).click
    end
  end

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
  menu_link :account, :text=>"Account"

  # Clicks the "Aliases" link in the Administration Workspace
  # menu, then should be followed by the Aliases class.
  menu_link :aliases, :text=>"Aliases"

  # Clicks the link for the Administration Workspace, then
  # should be followed by the MyWorkspace class.
  menu_link :administration_workspace, :text=>"Administration Workspace"

  # Clicks the Announcements link goes to
  # the Announcements class.
  menu_link :announcements, :class=>'icon-sakai-announcements'

  # Clicks the Assignments link, goes to
  # the AssignmentsList class.
  menu_link :assignments, :class=>"icon-sakai-assignment-grades"

  # BasicLTI class
  menu_link :basic_lti, :class=>"icon-sakai-basiclti"

  # Blogs class
  menu_link :blogs, :class=>"icon-sakai-blogwow"

  # Clicks the Blogger link in the Site menu and
  # instantiates the Blogger Class.
  menu_link :blogger, :class=>"icon-blogger"

  # Clicks the Calendar link, then instantiates
  # the Calendar class.
  menu_link :calendar, :text=>"Calendar"

  menu_link :certification, :text=>"Certification"

  # ChatRoom class
  menu_link :chat_room, :class=>"icon-sakai-chat"

  menu_link :configuration_viewer, :text=>"Configuration Viewer"
  menu_link :customizer, :text=>"Customizer"

  # JForum page class.
  menu_link :discussion_forums, :class=>"icon-sakai-jforum-tool"

  # DropBox class
  menu_link :drop_box, :class=>"icon-sakai-dropbox"

  menu_link :email, :text=>"Email"

  # Email Archive class
  menu_link :email_archive, :class=>"icon-sakai-mailbox"

  menu_link :email_template_administration, :text=>"Email Template Administration"

  # EvaluationSystem class
  menu_link :evaluation_system, :class=>"icon-sakai-rsf-evaluation"

  # Feedback class
  menu_link :feedback, :class=>"icon-sakai-postem"

  # Forms class
  menu_link :forms, :text=>"Forms", :class=>"icon-sakai-metaobj"

  # Forums class.
  menu_link :forums, :text=>"Forums"

  # Glossary Class.
  menu_link :glossary, :text=>"Glossary"

  # Gradebook Class.
  menu_link :gradebook, :text=>"Gradebook"

  # Gradebook2 class
  menu_link :gradebook2, :text=>"Gradebook2"

  menu_link :help, :text=>"Help"

  # Home class--unless the target page happens to be
  # My Workspace, in which case the MyWorkspace
  # page should be used.
  menu_link :home, :text=>"Home"

  # Job Scheduler class.
  menu_link :job_scheduler, :text=>"Job Scheduler"

  # Lessons class
  menu_link :lessons, :text=>"Lessons"

  menu_link :lesson_builder, :text=>"Lesson Builder"
  menu_link :link_tool, :text=>"Link Tool"
  menu_link :live_virtual_classroom, :text=>"Live Virtual Classroom"

  # Matrices Class
  menu_link :matrices, :text=>"Matrices"

  # MediaGallery class
  menu_link :media_gallery, :class=>"icon-sakai-kaltura"

  menu_link :membership, :text=>"Membership"
  menu_link :memory, :text=>"Memory"

  # Messages class.
  menu_link :messages, :text=>"Messages"

  menu_link :my_sites, :text=>"My Sites"

  # MyWorkspace Class.
  menu_link :my_workspace, :text=>"My Workspace"

  # News
  menu_link :news, :class=>"icon-sakai-news"

  menu_link :online, :text=>"On-Line"
  menu_link :oauth_providers, :text=>"Oauth Providers"
  menu_link :oauth_tokens, :text=>"Oauth Tokens"
  menu_link :openSyllabus, :text=>"OpenSyllabus"

  # Podcasts
  menu_link :podcasts, :class=>"icon-sakai-podcasts"

  # Polls class
  menu_link :polls, :class=>"icon-sakai-poll"

  # Portfolios class
  menu_link :portfolios, :class=>"icon-osp-presentation"

  # PortfolioTemplates
  menu_link :portfolio_templates, :text=>"Portfolio Templates"

  menu_link :preferences, :text=>"Preferences"

  menu_link :profile, :text=>"Profile"

  # Profile2 class
  menu_link :profile2, :class=>"icon-sakai-profile2"

  menu_link :realms, :text=>"Realms"

  # Resources class.
  menu_link :resources, :text=>"Resources"

  # Roster
  menu_link :roster, :class=>"icon-sakai-site-roster"

  menu_link :rsmart_support, :text=>"rSmart Support"

  # Because "Search" is used in many pages,
  # The Search button found in the Site Management
  # Menu must be given the more explicit name
  menu_link :site_management_search, :class=>"icon-sakai-search"

  # Sections
  menu_link :sections, :class=>"icon-sakai-sections"

  menu_link :site_archive, :text=>"Site Archive"

  # SiteEditor class.
  menu_link :site_editor, :text=>"Site Editor"

  # SiteSetup class.
  menu_link :site_setup, :text=>"Site Setup"

  menu_link :site_statistics, :text=>"Site Statistics"

  # Sites class.
  menu_link :sites, :class=>"icon-sakai-sites"

  menu_link :skin_manager, :text=>"Skin Manager"
  menu_link :super_user, :text=>"Super User"

  # Styles
  menu_link :styles, :text=>"Styles"

  # Syllabus class.
  menu_link :syllabus, :text=>"Syllabus"

  # AssessmentsList class OR the TakeAssessmentList for students
  menu_link :assessments, :class=>"icon-sakai-samigo"

  # UserMembership
  menu_link :user_membership, :class=>"icon-sakai-usermembership"

  # Users
  menu_link :users, :class=>"icon-sakai-users"

  # WebContent
  menu_link :web_content, :class=>"icon-sakai-iframe"

  # Wikis
  menu_link :wiki, :class=>"icon-sakai-rwiki"

  # The Page Reset button, found on all Site pages
  menu_link :reset, :href=>/tool-reset/

  # Login class.
  menu_link :logout, :text=>"Logout"
  alias :log_out :logout
  alias :sign_out :logout

end
