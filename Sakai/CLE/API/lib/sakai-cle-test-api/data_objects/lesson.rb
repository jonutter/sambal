class ModuleObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :title, :description, :keywords, :start_date, :end_date, :site, :href

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

  alias :name :title

  def create
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    lessons unless @browser.title=~/Lessons$/
    reset
    on_page Lessons do |page|
      page.add_module
    end
    on_page AddEditModule do |page|
      page.title.set @title
      page.description.set @description
      page.keywords.set @keywords
      page.start_date.set @start_date
      page.end_date.set @end_date
      page.add
    end
    on_page ConfirmModule do |page|
      page.return_to_modules
    end
    on_page Lessons do |list|
      @href = list.href @title
    end
  end

end

class ContentSectionObject

  include PageHelper
  include Utilities
  include Workflows

  attr_accessor :site, :module, :title, :instructions, :modality, :content_type,
                :copyright_status, :editor_content, :file_folder, :file_name, :file_path,
                :url, :url_title, :file_description, :url_description, :href

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
    @file_folder=options[:file_folder]
    @url=options[:url]
    @url_title=options[:url_title]
    @url_description=options[:url_description]
    raise "Your modality variable must be an Array containing one or more keys\nthat match the checkbox methods, like this:\n[:uncheck_textual, :check_visual, :check_auditory]" unless @modality.class==Array
    raise "You must specify a Site for your Section" if @site==nil
    raise "You must specify a Module for your Section" if @module==nil
  end

  alias :name :title

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
      page.title.set @title
      page.instructions.set @instructions
      @modality.each do |content|
        page.send(content)
      end
      page.content_type.select @content_type unless @content_type==nil
    end

    on AddEditContentSection do |page| # Note we are reinstantiating the class here because of
                                       # an issue with Selenium Webdriver throwing a
                                       # WeakReference error, given the partial page reload.
      case @content_type
        when "Compose content with editor"
          page.enter_source_text page.content_editor, @editor_content
        when "Upload or link to a file"
          page.select_a_file
          on_page LessonAddAttachment do |add|
            add.upload_local_file @file_name, @file_path
            add.continue
          end
          page.file_description.set @file_description
        when "Link to new or existing URL resource on server"
          page.select_url
          on_page SelectingContent do |select|
            select.new_url.set @url
            select.url_title.set @url_title
            select.continue
          end
          page.url_description.set @url_description
        when "Upload or link to a file in Resources"
          page.select_or_upload_file
          on_page ResourcesBase do |add|
            add.open_folder @file_folder unless @file_folder == nil
            add.select_file @file_name
            add.continue
          end
        else
          raise "You have a typo in what you've specified for your Section's content type.\nIt must be one of the options contained in the dropdown."
      end
      page.copyright_status.select @copyright_status
      page.add
    end
    on ConfirmSectionAdd do |confirm|
      confirm.finish
    end
    on Lessons do |list|
      @href = list.href @title
    end
  end

  def edit opts={}
    open_my_site_by_name @site unless @browser.title=~/#{@site}/
    lessons unless @browser.title=~/Lessons$/
    reset
    on Lessons do |list|
      list.check_section @title
      list.edit
    end
    on AddEditContentSection do |edit|
      edit.title.set opts[:title] unless opts[:title]==nil
      edit.instructions.set opts[:instructions] unless opts[:instructions]==nil
      if opts[:modality].class==Array
        opts[:modality].each do |item|
          edit.send(item)
        end
      end

      # TODO: Add code here for updating attached resources

      edit.enter_source_text(edit.content_editor, opts[:editor_content]) unless opts[:editor_content]==nil

      # TODO: Add code here for updating remaining variables

      edit.finish
    end
    @title=opts[:title] unless opts[:title]==nil
    @instructions=opts[:instructions] unless opts[:instructions]==nil
    @modality=opts[:modality] unless opts[:modality]==nil
  end
end