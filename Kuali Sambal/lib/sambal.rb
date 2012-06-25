require 'watir-webdriver'
require 'sambal/page_helper'
require 'sambal/page_maker'
require 'sambal/kuali_student'
Dir["#{File.dirname(__FILE__)}/sambal/*.rb"].each {|f| require f }