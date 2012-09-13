class ModuleObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :title, :description, :keywords, :start_date, :end_date, :site

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums
    }
    options = defaults.merge(opts)

    @title=options[:title]
    @description=options[:description]
    @keywords=options[:keywords]
    @start_date=options[:start_date]
    @end_date=options[:end_date]
    @site=options[:site]
    raise "You must specify a Site name for your lesson" if @site==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    lessons unless @browser.title=~/Lessons$/
    reset
    on_page Lessons do |page|
      page.add_module
    end
    on_page AddEditModule do |page|
      page.title=@title
      page.description=@description
      page.keywords=@keywords
      page.start_date=@start_date
      page.end_date=@end_date
      page.add
    end
    on_page ConfirmModule do |page|
      page.return_to_modules
    end
  end

end

class ContentSectionObject

  include PageObject
  include Utilities
  include ToolsMenu

  attr_accessor :site, :module, :title, :instructions, :modality, :content_type,
                :copyright_status, :editor_content, :file_name, :file_path, :url, :url_title,
                :file_description, :url_description

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      :title=>random_alphanums,
      :copyright_status=>"Public Domain",
      :modality=>[:check_textual]
    }
    options = defaults.merge(opts)

    @site=options[:site]
    @module=options[:module]
    @title=options[:title]
    @instructions=options[:instructions]
    @modality=options[:modality]
    @content_type=options[:content_type]
    @copyright_status=options[:copyright_status]
    @editor_content=options[:editor_content]
    @file_name=options[:file_name]
    @file_path=options[:file_path]
    @file_description=options[:file_description]
    @url=options[:url]
    @url_title=options[:url_title]
    @url_description=options[:url_description]
    raise "Your modality variable must be an Array containing one or more keys\nthat match the checkbox methods, like this:\n[:uncheck_textual, :check_visual, :check_auditory]" unless @modality.class==Array
    raise "You must specify a Site for your Section" if @site==nil
    raise "You must specify a Module for your Section" if @module==nil
  end

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    lessons unless @browser.title=~/Lessons$/
    reset
    on_page Lessons do |page|
      page.open_lesson @module
    end
    on_page AddEditModule do |page|
      page.add_content_sections
    end
    on_page AddEditContentSection do |page|
      page.title=@title
      page.instructions=@instructions
      @modality.each do |content|
        page.send(content)
      end
      page.content_type=@content_type unless @content_type==nil
      sleep 3 # Need to wait for page refresh
      case @content_type
        when "Compose content with editor"
          page.source(page.content_editor)
          page.source=@editor_content
        when "Upload or link to a file"
          page.select_a_file
          on_page LessonAddAttachment do |subpage|
            subpage.upload_local_file @file_name, @file_path
            subpage.continue
          end
          page.file_description=@file_description
        when "Link to new or existing URL resource on server"
          page.select_url
          on_page SelectingContent do |subpage|
            subpage.new_url=@url
            subpage.url_title=@url_title
            subpage.continue
          end
          page.url_description=@url_description
        when "Upload or link to a file in Resources"
          page.select_or_upload_file
          on_page AddFiles do |subpage|
            subpage.select @file_name
            subpage.continue
          end
        else
          raise "You have a typo in what you've specified for your Section's content type.\nIt must be one of the options contained in the dropdown."
      end
      page.copyright_status=@copyright_status
      page.add
    end
  end
end