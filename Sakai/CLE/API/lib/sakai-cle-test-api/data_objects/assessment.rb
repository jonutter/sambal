class AssessmentObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :title, :site

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums,
      :site=>"placeholder"
    }
    options = defaults.merge(opts)
    @title=options[:title]
    @site=options[:site]
    raise "You must specify a Site for your Assessment" if @site==nil
  end

  def create
    my_workspace.open_my_site_by_name @site unless @browser.title=~/#{@site}/
    tests_and_quizzes unless @browser.title=~/Tests & Quizzes$/
    on_page AssessmentsList do |page|
      page.title.set @title
      page.create
    end
    # Do more here eventually...
  end

end