#================
# Matrix Pages for a Portfolio Site
#================

#
class Matrices < BasePage

  frame_element

  # Clicks the Add link and instantiates
  # the AddEditMatrix Class.
  def add
    frm.link(:text=>"Add").click
    AddEditMatrix.new(@browser)
  end

  # Clicks the "Edit" link for the specified
  # Matrix item, then instantiates the EditMatrixCells.
  def edit(matrixname)
    frm.table(:class=>"listHier lines nolines").tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Edit").click
    EditMatrixCells.new(@browser)
  end

  # Clicks the "Preview" link for the specified
  # Matrix item.
  def preview(matrixname)
    frm.table(:class=>"listHier lines nolines").tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Preview").click
  end

  # Clicks the "Publish" link for the specified
  # Matrix item, then instantiates the ConfirmPublishMatrix Class.
  def publish(matrixname)
    frm.table(:class=>"listHier lines nolines").tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Publish").click
    ConfirmPublishMatrix.new(@browser)
  end


end

#
class AddEditMatrix < BasePage

  frame_element

  # Clicks the "Create Matrix" button and
  # instantiates the Matrices Class.
  def create_matrix
    frm.button(:value=>"Create Matrix").click
    Matrices.new(@browser)
  end

  # Clicks the "Save Changes" butotn and
  # instantiates the EditMatrixCells Class.
  def save_changes
    frm.button(:value=>"Save Changes").click
    EditMatrixCells.new(@browser)
  end

  # Clicks the "Select Style" link and
  # instantiates the SelectMatrixStyle Class.
  def select_style
    frm.link(:text=>"Select Style").click
    SelectMatrixStyle.new(@browser)
  end

  # Clicks the "Add Column" link and
  # instantiates the AddEditColumn Class.
  def add_column
    frm.link(:text=>"Add Column").click
    AddEditColumn.new(@browser)
  end

  # Clicks the "Add Row" link and instantiates
  # the AddEditRow Class.
  def add_row
    frm.link(:text=>"Add Row").click
    AddEditRow.new(@browser)
  end


  element(:title) { |b| b.frm.text_field(:id=>"title-id") }

end

#
class SelectMatrixStyle < BasePage

  frame_element

  # Clicks the "Go Back" button and
  # instantiates the AddEditMatrix Class.
  def go_back
    frm.button(:value=>"Go Back").click
    AddEditMatrix.new(@browser)
  end

  # Clicks the "Select" link for the specified
  # Style, then instantiates the AddEditMatrix Class.
  def select_style(stylename)
    frm.table(:class=>/listHier lines/).tr(:text=>/#{Regexp.escape(stylename)}/).link(:text=>"Select").click
    AddEditMatrix.new(@browser)
  end

end

#
class AddEditColumn < BasePage

  frame_element

  # Clicks the "Update" button, then
  # instantiates the AddEditMatrix Class.
  def update
    frm.button(:value=>"Update").click
    AddEditMatrix.new(@browser)
  end


  element(:name) { |b| b.frm.text_field(:name=>"description") }

end

#
class AddEditRow < BasePage

  frame_element

  # Clicks the "Update" button, then
  # instantiates the AddEditMatrix Class.
  def update
    frm.button(:value=>"Update").click
    AddEditMatrix.new(@browser)
  end


  element(:name) { |b| b.frm.text_field(:name=>"description") }
  element(:background_color) { |b| b.frm.text_field(:id=>"color-id") }
  element(:font_color) { |b| b.frm.text_field(:id=>"textColor-id") }

end

#
class EditMatrixCells < BasePage

  frame_element

  # Clicks on the cell that is specified, based on
  # the row number, then the column number.
  #
  # Note that the numbering begins in the upper left
  # of the Matrix, with (1, 1) being the first EDITABLE
  # cell, NOT the first cell in the table itself.
  #
  # In other words, ignore the header row and header column
  # in your count (or, if you prefer, consider those
  # to be numbered "0").
  def edit(row, column)
    frm.div(:class=>"portletBody").table(:summary=>"Matrix Scaffolding (click on a cell to edit)").tr(:index=>row).td(:index=>column-1).fire_event("onclick")
    EditCell.new(@browser)
  end

  # Clicks the "Return to List" link and
  # instantiates the Matrices Class.
  def return_to_list
    frm.link(:text=>"Return to List").click
    Matrices.new(@browser)
  end

end

#
class EditCell < BasePage

  frame_element

  thing(:select_evaluators_link) { |b| b.frm.link(:text=>"Select Evaluators") }

  # Clicks the "Select Evaluators" link
  # and instantiates the SelectEvaluators Class.
  def select_evaluators
    select_evaluators_link.wait_until_present
    select_evaluators_link.click
    SelectEvaluators.new(@browser)
  end

  # Clicks the Save Changes button and instantiates
  # the EditMatrixCells Class.
  def save_changes
    frm.button(:value=>"Save Changes").click
    EditMatrixCells.new(@browser)
  end


  element(:title) { |b| b.frm.text_field(:id=>"title-id") }
  element(:use_default_reflection_form) { |b| b.frm.checkbox(:id=>"defaultReflectionForm") }
  element(:reflection) { |b| b.frm.select(:id=>"reflectionDevice-id") }
  element(:use_default_feedback_form) { |b| b.frm.checkbox(:id=>"defaultFeedbackForm") }
  element(:feedback) { |b| b.frm.select(:id=>"reviewDevice-id") }
  element(:use_default_evaluation_form) { |b| b.frm.checkbox(:id=>"defaultEvaluationForm") }
  element(:evaluation) { |b| b.frm.select(:id=>"evaluationDevice-id") }
  element(:use_default_evaluators) { |b| b.frm.checkbox(:id=>"defaultEvaluators") }

end

#
class SelectEvaluators < BasePage

  frame_element

  # Clicks the "Save" button and
  # instantiates the EditCell Class.
  def save
    frm.button(:value=>"Save").click
    EditCell.new(@browser)
  end


  element(:users) { |b| b.frm.select(:id=>"mainForm:availableUsers") }
  element(:selected_users) { |b| b.frm.select(:id=>"mainForm:selectedUsers") }
  element(:roles) { |b| b.frm.select(:id=>"mainForm:audSubV11:availableRoles") }
  element(:selected_roles) { |b| b.frm.select(:id=>"mainForm:audSubV11:selectedRoles") }
  action(:add_users) { |b| b.frm.button(:id=>"mainForm:add_user_button").click }
  action(:remove_users) { |b| b.frm.button(:id=>"mainForm:remove_user_button").click }
  action(:add_roles) { |b| b.frm.button(:id=>"mainForm:audSubV11:add_role_button").click }
  action(:remove_roles) { |b| b.frm.button(:id=>"mainForm:audSubV11:remove_role_button").click }

end

#
class ConfirmPublishMatrix < BasePage

  frame_element

  # Clicks the "Continue" button and
  # instantiates the Matrices Class.
  def continue
    frm.button(:value=>"Continue").click
    Matrices.new(@browser)
  end

end