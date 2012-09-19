class WikiObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor

  def initialize(browser, opts={})
    @browser = browser

    defaults = {

    }
    options = defaults.merge(opts)

  end

  def create
    my_workspace unless @browser.title=~/My Workspace/
    wiki unless @browser.title=~/Wiki$/


  end

end