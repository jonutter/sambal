#
class Blogs
  include ToolsMenu
  include BlogsMethods
  include BlogsMenuButtons
end

class AddBlogEntry
  include ToolsMenu
  include AddBlogEntryMethods
  include BlogsMenuButtons
end

class BlogsList
  include ToolsMenu
  include BlogsListMethods
  include BlogsMenuButtons
end