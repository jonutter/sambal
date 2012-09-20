class AssignmentObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :title, :site, :instructions, :id, :link

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :title=>random_alphanums,
        :instructions=>random_multiline(500, 10, :string)
    }
    options = defaults.merge(opts)

    @title=options[:title]
    @instructions=options[:instructions]
    @site=options[:site]
    raise "You must specify a Site for your Assignment" if @site==nil
  end

  alias :name :title

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/

    # Go to assignments page
    assignments unless @browser.title=~/Assignments$/

    on_page AssignmentsList do |page|
      page.add
    end
    on_page AssignmentAdd do |add|
      add.title.set @title
      add.instructions=@instructions
      add.post
    end
    on_page AssignmentsList do |list|
      @id = list.get_assignment_id @title
      @link = list.assignment_href @title
    end
  end

  def edit opts={}
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    assignments unless @browser.title=~/Assignments$/
    on AssignmentsList do |list|
     list.edit_assignment @title
    end
    on AssignmentAdd do |edit|
      edit.title.set opts[:title] unless opts[:title] == nil
      unless opts[:instructions] == nil
        edit.enter_source_text edit.editor, opts[:instructions]
      end
      edit.post
    end

    @title=opts[:title] unless opts[:title] == nil
    @instructions=opts[:instructions] unless opts[:instructions] == nil

  end

end