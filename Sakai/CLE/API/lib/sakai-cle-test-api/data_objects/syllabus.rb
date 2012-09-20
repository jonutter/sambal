class SyllabusObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :title, :content, :site

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :title=>random_alphanums,
        :content=>random_multiline(50, 5, :alpha)
    }
    options = defaults.merge(opts)
    @title=options[:title]
    @content=options[:content]
    @site=options[:site]
    raise "You must specify a Site for the announcement" if @site==nil
  end

  alias :name :title

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    syllabus unless @browser.title=~/Syllabus$/
    on Syllabus do |add|
      add.create_edit
      add.add
    end
    on AddEditSyllabusItem do |create|
      create.title.set @title
      create.enter_source_text create.editor, @content
      create.post
    end
  end

end