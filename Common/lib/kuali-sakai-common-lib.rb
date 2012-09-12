require 'watir-webdriver'
require 'page-object'
require 'kuali-sakai-common-lib/gem_ext'
require 'kuali-sakai-common-lib/core-ext'
require 'kuali-sakai-common-lib/utilities'
require 'kuali-sakai-common-lib/rich_text'
Dir["#{File.dirname(__FILE__)}/kuali-sakai-common-lib/*.rb"].each { |f| require f }