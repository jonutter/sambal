module FCKEditor

  # This has to be defined this way because there several pages
  # that have multiple rich text editors.
  def source(editor)
    editor.div(:title=>/Source/).wait_until_present
    editor.div(:title=>/Source/).click
  end

  def select_all(editor)
    editor.div(:title=>"Select All").wait_until_present
    editor.div(:title=>"Select All").click
  end

  def enter_source_text(editor, text)
    source(editor)
    editor.text_field(:class=>"SourceField").wait_until_present
    editor.text_field(:class=>"SourceField").set text
  end

  def get_source_text(editor)
    source(editor)
    editor.text_field(:class=>"SourceField").wait_until_present
    editor.text_field(:class=>"SourceField").value
  end

end