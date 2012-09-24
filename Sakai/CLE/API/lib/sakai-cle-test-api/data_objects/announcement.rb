class AnnouncementObject

  include Utilities
  include PageHelper
  include Workflows

  attr_accessor :title, :body, :site, :link, :access, :availability,
                :subject, :saved_by, :date, :creation_date, :groups,
                :message, :message_html

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
    raise "You must specify a Site for the announcement" if @site==nil
  end

  alias :name :title

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    announcements unless @browser.title=~/Announcements$/
    on_page Announcements do |page|
      page.add
    end
    on_page AddEditAnnouncements do |page|
      page.title.set @title
      page.enter_source_text page.editor, @body
      page.add_announcement
      @creation_date=make_date Time.now
    end
    on_page Announcements do |page|
      @link = page.href(@title)
    end
  end

  def edit opts={}
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    announcements unless @browser.title=~/Announcements$/
    on_page Announcements do |list|
      list.edit @title
    end
    on AddEditAnnouncements do |edit|
      edit.title.set opts[:title] unless opts[:title]==nil
      edit.send(opts[:access]) unless opts[:access]==nil
      edit.send(opts[:availability]) unless opts[:availability]==nil
      unless opts[:body]==nil
        edit.enter_source_text edit.editor, opts[:body]
      end
      edit.save_changes
    end
    @title=opts[:title] unless opts[:title]==nil
    @body=opts[:body] unless opts[:body]==nil
    @access=opts[:access]
    @availability=opts[:availability]
  end

  def view
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    announcements unless @browser.title=~/Announcements$/
    on Announcements do |list|
      list.view @title
    end
    on ViewAnnouncement do |view|
      @subject=view.subject
      @saved_by=view.saved_by
      @date=view.date
      @groups=view.groups
      @message=view.message
      @message_html=view.message_html
    end
  end

end