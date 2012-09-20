class WikiObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :title, :content, :site, :href

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums,
      :content=>"{worksiteinfo}\n{sakai-sections}"
    }
    options = defaults.merge(opts)

    @title=options[:title]
    @content=options[:content]
    @site=options[:site]
    raise "You need to specify a site for your wiki" if @site==nil
  end

  alias :name :title

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    wiki unless @browser.title=~/Wiki$/
    on Rwiki do |home|
      home.edit
      @current_content = home.content.value
      @updated_content = "[#{@title}]\n\n"+@current_content
      home.content.set @updated_content
      home.save
      @href = home.wiki_href "#{@title}?"
      home.open_wiki "#{@title}?"
      home.edit
      home.content.set @content
      home.save
    end
  end

  def edit opts={}
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    wiki unless @browser.title=~/Wiki$/
    on Rwiki do |edit|
      edit.open_wiki @title
      edit.edit
      # more here
    end
  end

end