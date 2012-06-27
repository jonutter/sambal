TEST_SITE = "http://env1.ks.kuali.org" # TODO: Put this elsewhere when code gets gemmified

require 'watir-webdriver'
require 'rspec'
require '../lib/sambal/page_helper' # TODO - These will need to be updated when this get gemmified
require '../lib/sambal/page_maker'
require '../lib/sambal/kuali_student'
Dir["#{File.dirname(__FILE__)}/sambal/kspages/*.rb"].each {|f| require f }