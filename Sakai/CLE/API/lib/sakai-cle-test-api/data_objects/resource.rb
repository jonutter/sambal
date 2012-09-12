class FileObject

  include PageObject
  include Utilities
  include ToolsMenu

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
  include PageObject
  include Utilities
  include ToolsMenu

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
  end

  def create
    unless @browser.title=~/#{@site} : Resources/
      home = open_my_site_by_name @site
      home.resources
    end
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
  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
  end

  def create

  end

end

class HTMLPageObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :name, :description, :site, :folder, :html, :url

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :name=>random_alphanums,
        :description=>random_multiline(500, 10, :string),
        :html=>"<body>Body</body>"
    }
    options = defaults.merge(opts)

    @name = options[:name]
    @description = options[:description]
    @site = options[:site]
    @folder = options[:folder]
    @html = options[:html]
  end

  def create
    unless @browser.title=~/#{@site} : Resources/
      home = open_my_site_by_name @site
      home.resources
    end
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
  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
  end

  def create

  end

end

class CitationListObject
  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {}
    options = defaults.merge(opts)
  end

  def create

  end

end