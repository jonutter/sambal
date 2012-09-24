#================
# Evaluation System Pages
#================

# The "Evaluations Dashboard"
class EvaluationSystem < BasePage

  frame_element

  # MyTemplates
  action(:my_templates) { |b| b.frm.link(:text=>"My Templates").click }

  # AddTemplateTitle
  action(:add_template) { |b| b.frm.link(:text=>"Add Template").click }

  # TakeEvaluation
  def take_evaluation(evaluation_name)
    frm.div(:class=>"summaryBox").table(:text=>/#{Regexp.escape(evaluation_name)}/).link.click
    TakeEvaluation.new(@browser)
  end

  def status_of(evaluation_name)
    frm.div(:class=>"summaryBox").table(:text=>/#{Regexp.escape(evaluation_name)}/)[1][1].text
  end

end

#
class AddTemplateTitle < BasePage

  frame_element

  def save
    frm.button(:value=>"Save").click
    EditTemplate.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"title") }
  element(:description) { |b| b.frm.text_area(:id=>"description") }

end


#
class EditTemplate < BasePage

  frame_element

  def item_text=(text)
    frm.frame(:id, "item-text___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  action(:new_evaluation) { |b| b.frm.link(:text=>"New evaluation").click }

  def add
    frm.button(:value=>"Add").click
    frm.frame(:id, "item-text___Frame").td(:id, "xEditingArea").wait_until_present
  end

  def save_item
    frm.button(:value=>"Save item").click
    frm.link(:text=>"New evaluation").wait_until_present
    EditTemplate.new @browser
  end

  element(:item) { |b| b.frm.select_list(:id=>"add-item-control::add-item-classification-selection").click }
end


#
class NewEvaluation < BasePage

  include FCKEditor
  frame_element

  expected_element :editor

  element(:editor) { |b| b.frm.frame(:id, "instructions:1:input___Frame") }

  def continue_to_settings
    frm.button(:value=>"Continue to Settings").click
    EvaluationSettings.new(@browser)
  end

  def instructions=(text)
    frm.frame(:id, "instructions:1:input___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end

  element(:title) { |b| b.frm.text_field(:id=>"title") }

end


#
class EvaluationSettings < BasePage

  frame_element

  def continue_to_assign_to_courses
    frm.button(:value=>"Continue to Assign to Courses").click
    EditEvaluationAssignment.new(@browser)
  end


end


#
class EditEvaluationAssignment < BasePage

  frame_element

  def save_assigned_groups
    frm.button(:value=>"Save Assigned Groups").click
    ConfirmEvaluation.new(@browser)
  end

  def check_group(title)
    frm.table(:class=>"listHier lines nolines").wait_until_present
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(title)}/).checkbox(:name=>"selectedGroupIDs").set
  end

  action(:assign_to_evaluation_groups) { |b| b.frm.link(:text=>"Assign to Evaluation Groups").click }
end


#
class ConfirmEvaluation < BasePage

  frame_element

  def done
    frm.button(:value=>"Done").click
    MyEvaluations.new(@browser)
  end

end

#
class MyEvaluations < BasePage

  frame_element


end

#
class TakeEvaluation < BasePage

  frame_element

  def submit_evaluation
    frm.button(:value=>"Submit Evaluation").click
    EvaluationSystem.new(@browser)
  end


end