#================
# Polls pages
#================

#
class Polls < BasePage

  frame_element

  action(:add) { |b| b.frm.link(:text=>"Add").click }

  def questions
    questions = []
    frm.table(:id=>"sortableTable").rows.each do |row|
      questions << row[0].link.text
    end
    return questions
  end

  # Returns an array containing the list of poll questions displayed.
  def list
    list = []
    frm.table(:id=>"sortableTable").rows.each_with_index do |row, index|
      next if index==0
      list << row[0].link(:href=>/voteQuestion/).text
    end
    return list
  end

end

#
class AddEditPoll < BasePage

  frame_element
  include FCKEditor

  expected_element :editor

  element(:editor) { |b| b.frm.frame(:id, "newpolldescr::input___Frame") }

  def additional_instructions=(text)
    editor.td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  action(:save_and_add_options) { |b| b.frm.button(:value=>"Save and add options").click }
  action(:save) { |b| b.frm.button(:value=>"Save").click }
  element(:question) { |b| b.frm.text_field(:id=>"new-poll-text") }

end

#
class AddAnOption < BasePage

  frame_element
  include FCKEditor

  expected_element :editor

  element(:editor) { |b| b.frm.frame(:id, "optText::input___Frame") }

  def answer_option=(text)
    editor.td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  action(:save) { |b| b.frm.button(:value=>"Save").click }
  action(:save_and_add_options) { |b| b.frm.button(:value=>"Save and add options").click }

end