$: << File.dirname(__FILE__)+'/../../lib'

require 'sambal'

World PageHelper

browser = Watir::Browser.new

Before do
  @browser = browser
end

at_exit { browser.close }