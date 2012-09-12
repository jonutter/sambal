class WebContentObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :title, :source, :site

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums,
      :source=>"www.rsmart.com"
    }
    options = defaults.merge(opts)

    @title=options[:title]
    @source=options[:source]
    @site=options[:site]
    raise "You need to specify a site for your web content" if @site==nil
  end

  def create
    my_workspace unless @browser.title=~/My Workspace/
    site_setup unless @browser.title=~/Site Setup$/
    on_page SiteSetup do |page|
      page.edit @site
    end
    on_page SiteEditor do |page|
      page.edit_tools
    end
    on_page EditSiteTools do |page|
      page.check_web_content
      page.continue
    end
    on_page AddMultipleTools do |page|
      page.web_content_title=@title
      page.web_content_source=@source
      page.continue
    end
    on_page ConfirmSiteToolsEdits do |page|
      page.finish
    end
sleep 10
    on_page SiteEditor do |page|
      page.return_to_sites_list
    end
  end

end