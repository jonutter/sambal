module FCKEditor

  # This has to be defined this way because there several pages
  # that have multiple rich text editors.
  def source(editor)
    editor.div(:title=>/Source/).click
  end

  def select_all(editor)
    editor.div(:title=>"Select All").click
  end

end