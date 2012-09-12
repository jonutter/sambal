class AssignmentObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :title, :site, :instructions, :id, :link

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        :title=>random_alphanums,
        :instructions=>random_multiline(500, 10, :string),
        :site=>"placeholder"

    }
    options = defaults.merge(opts)

    @title=options[:title]
    @instructions=options[:instructions]
    @site=options[:site]
  end

  def create
    home = my_workspace.open_my_site_by_name @site

    # Go to assignments page
    assignments = home.assignments

    add = assignments.add
    add.title=@title
    add.instructions=@instructions
    list = add.post
    @id = list.get_assignment_id @title
    @link = list.assignment_href @title
  end


  def edit opts={}
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    assignments unless @browser.title=~/Assignments$/
    list = AssignmentsList.new @browser
    edit = list.edit_assignment @title
    edit.title=opts[:title] unless opts[:title] == nil
    unless opts[:instructions] == nil
      edit.source(edit.editor)
      edit.source=opts[:instructions]
    end
    edit.post

    @title=opts[:title] unless opts[:title] == nil
    @instructions=opts[:instructions] unless opts[:instructions] == nil

  end

end