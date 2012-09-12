class AnnouncementObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :title, :body, :site, :link

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :title=>random_alphanums,
        :body=>random_multiline(500, 10, :alpha)
    }
    options = defaults.merge(opts)
    @title=options[:title]
    @body=options[:body]
    @site=options[:site]
  end

  def create
    home = my_workspace.open_my_site_by_name @site
    announcements = home.announcements
    add = announcements.add
    add.title=@title
    add.body=@body
    list = add.add_announcement
    @link = list.href(@title)
  end

end