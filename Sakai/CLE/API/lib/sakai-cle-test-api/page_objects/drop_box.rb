#================
# Drop Box pages
#================

#
class DropBox < AddFiles

  include ToolsMenu

  def initialize(browser)
    @browser = browser

    @@classes = {
        :this => "DropBox",
        :parent => "DropBox",
        :second => "",
        :third => ""
    }
  end

end