class FileObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
  end

  def create

  end

end

class FolderObject
  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :name, :parent_folder, :site

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :name=>random_alphanums
    }
    options = defaults.merge(opts)

    @name = options[:name]
    @parent_folder = options[:parent_folder]
    @site = options[:site]
    raise "You must specify a Site for your Folder" if @site==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    resources unless @browser.title=~/Resources$/
    on_page Resources do |page|
      page.create_subfolders_in @parent_folder
    end
    on_page CreateFolders do |page|
      page.folder_name.set @name
      page.create_folders_now
    end
  end

end

class WebLinkObject
  include PageHelper
  include Utilities
  include Workflows

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
    @site = options[:site]
    raise "You must specify a Site for your Web Link" if @site==nil
  end

  def create

  end

end

class HTMLPageObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :name, :description, :site, :folder, :html, :url

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :name=>random_alphanums,
        :description=>random_multiline(100, 15, :alpha),
        :html=>"<body>Body</body>"
    }
    options = defaults.merge(opts)

    @name = options[:name]
    @description = options[:description]
    @site = options[:site]
    @folder = options[:folder]
    @html = options[:html]
    @site = options[:site]
    raise "You must specify a Site for your HTML Page" if @site==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    resources unless @browser.title=~/Resources$/
    on_page Resources do |page|
      page.create_html_page_in @folder
    end
    on_page CreateHTMLPageContent do |page|
      page.source(page.editor)
      page.source=@html
      page.continue
    end
    on_page CreateHTMLPageProperties do |page|
      page.name.set @name
      page.description.set @description
      # Put more here as needed later
      page.finish
    end
    on_page Resources do |page|
      @url = page.href(@name)
    end
  end

end

class TextDocumentObject
  include PageHelper
  include Utilities
  include Workflows

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
    @site = options[:site]
    raise "You must specify a Site for your Text Document" if @site==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    resources unless @browser.title=~/Resources$/
  end

end

class CitationListObject
  include PageHelper
  include Utilities
  include Workflows

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
    @site = options[:site]
    raise "You must specify a Site for your Citations List" if @site==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    resources unless @browser.title=~/Resources$/
  end

end