# Note that this class is for icon-sakai-forums. NOT jforums.
class ForumObject

  include PageHelper
  include Utilities
  include Workflows
  
  attr_accessor :site, :title, :short_description, :description
  
  def initialize(browser, opts={})
    @browser = browser
    
    defaults = {
      :title=>random_alphanums
    }
    options = defaults.merge(opts)
    
    @site=options[:site]
    @title=options[:title]
    @short_description=options[:short_description]
    @description=options[:description]
    raise "You need to specify a site for your Forum" if @site==nil
  end
    
  def create
    
  end
    
  def edit opts={}
    
  end
    
  def view
    
  end
    
  def delete
    
  end
  
end