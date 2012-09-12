class AssessmentObject

  include PageObject
  include Utilities
  include ToolsMenu

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
  end

  def create
    home = my_workspace.open_my_site_by_name @site
    assessments = home.tests_and_quizzes
    assessments.title=@title
    quiz = assessments.create
  end

end