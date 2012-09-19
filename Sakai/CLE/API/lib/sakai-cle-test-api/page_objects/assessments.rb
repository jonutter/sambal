
#================
# Assessments pages - "Samigo", a.k.a., "Tests & Quizzes"
#================

# Base Class for building Assessments
class AssessmentsBase <BasePage

  frame_element
  class << self
    def menu_bar_elements
      action(:assessments) { |b| b.frm.link(:text=>"Assessments").click }
      action(:assessment_types) { |b| b.frm.link(:text=>"Assessment Types").click }
      # Clicks the Question Pools link, goes to
      # the QuestionPoolsList class.
      action(:question_pools) { |b| b.frm.link(:text=>"Question Pools").click }
      action(:questions) { |b| b.frm.link(:text=>/Questions:/).click }
    end

    def question_page_elements
      element(:answer_point_value) { |b| b.frm.text_field(:id=>"itemForm:answerptr") }
      element(:assign_to_part) { |b| b.frm.select(:id=>"itemForm:assignToPart") }
      element(:assign_to_pool) { |b| b.frm.select(:id=>"itemForm:assignToPool") }
      element(:question_text) { |b| b.frm.text_field(:class=>"simple_text_area", :index=>0) }
      action(:save) { |b| b.frm.button(:value=>"Save").click }
      action(:cancel) { |b| b.frm.button(:id=>"itemForm:_id63").click }
      action(:add_attachments) { |b| b.frm.button(:value=>"Add Attachments").click }
    end

    def pool_page_elements
      element(:pool_name) { |b| b.frm.text_field(:id=>/:namefield/) }
      element(:department_group) { |b| b.frm.text_field(:id=>/:orgfield/) }
      element(:description) { |b| b.frm.text_field(:id=>/:descfield/) }
      element(:objectives) { |b| b.frm.text_field(:id=>/:objfield/) }
      element(:keywords) { |b| b.frm.text_field(:id=>/:keyfield/) }
      # QuestionPoolsList
      action(:save) { |b| b.frm.button(:id=>"questionpool:submit").click }
      action(:cancel) { |b| b.frm.button(:value=>"Cancel").click }
    end
  end
end

# The Course Tools "Tests and Quizzes" page for a given site.
# (Instructor view)
class AssessmentsList < AssessmentsBase

  menu_bar_elements

  expected_element :title

  # If the assessment is going to be made in the builder, then
  # use EditAssessment. There's no page class for markup text, yet.
  action(:create) { |b| b.frm.button(:value=>"Create").click }

  # Collects the titles of the Assessments listed as "Pending"
  # then returns them as an Array.
  def pending_assessment_titles
    titles =[]
    pending_table = frm.table(:id=>"authorIndexForm:coreAssessments")
    1.upto(pending_table.rows.size-1) do |x|
      titles << pending_table[x][1].span(:id=>/assessmentTitle/).text
    end
    return titles
  end

  # Collects the titles of the Assessments listed as "Published"
  # then returns them as an Array.
  def published_assessment_titles
    titles =[]
    published_table = frm.div(:class=>"tier2", :index=>2).table(:class=>"listHier", :index=>0)
    1.upto(published_table.rows.size-1) do |x|
      titles << published_table[x][1].span(:id=>/publishedAssessmentTitle/).text
    end
    return titles
  end

  # Returns an Array of the inactive Assessment titles displayed
  # in the list.
  def inactive_assessment_titles
    titles =[]
    inactive_table = frm.div(:class=>"tier2", :index=>2).table(:id=>"authorIndexForm:inactivePublishedAssessments")
    1.upto(inactive_table.rows.size-1) do |x|
      titles << inactive_table[x][1].span(:id=>/inactivePublishedAssessmentTitle/).text
    end
    return titles
  end

  # Opens the selected test for scoring
  # then instantiates the AssessmentTotalScores class.
  # @param test_title [String] the title of the test to be clicked.
  def score_test(test_title)
    frm.tbody(:id=>"authorIndexForm:_id88:tbody_element").row(:text=>/#{Regexp.escape(test_title)}/).link(:id=>/authorIndexToScore/).click
    AssessmentTotalScores.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"authorIndexForm:title") }
  element(:create_using_builder) { |b| b.frm.radio(:name=>"authorIndexForm:_id29", :index=>0) }
  element(:create_using_text) { |b| b.frm.radio(:name=>"authorIndexForm:_id29") }
  element(:select_assessment_type) { |b| b.frm.select(:id=>"authorIndexForm:assessmentTemplate") }
  action(:import) { |b| b.frm.button(:id=>"authorIndexForm:import").click }

end

# Page that appears when previewing an assessment.
# It shows the basic information about the assessment.
class PreviewOverview < BasePage

  frame_element

  # Scrapes the value of the due date from the page. Returns it as a string.
  def due_date
    frm.div(:class=>"tier2").table(:index=>0)[0][0].text
  end

  # Scrapes the value of the time limit from the page. Returns it as a string.
  def time_limit
    frm.div(:class=>"tier2").table(:index=>0)[3][0].text
  end

  # Scrapes the submission limit from the page. Returns it as a string.
  def submission_limit
    frm.div(:class=>"tier2").table(:index=>0)[6][0].text
  end

  # Scrapes the Feedback policy from the page. Returns it as a string.
  def feedback
    frm.div(:class=>"tier2").table(:index=>0)[9][0].text
  end

  # Clicks the Done button, then instantiates
  # the EditAssessment class.
  def done
    frm.button(:name=>"takeAssessmentForm:_id5").click
    EditAssessment.new(@browser)
  end

  action(:begin_assessment) { |b| b.frm.button(:id=>"takeAssessmentForm:beginAssessment3").click }

end

# The Settings page for a particular Assessment
class AssessmentSettings < AssessmentsBase

  menu_bar_elements

  # Scrapes the Assessment Type from the page and returns it as a string.
  def assessment_type_title
    frm.div(:class=>"tier2").table(:index=>0)[0][1].text
  end

  # Scrapes the Assessment Author information from the page and returns it as a string.
  def assessment_type_author
    frm.div(:class=>"tier2").table(:index=>0)[1][1].text
  end

  # Scrapes the Assessment Type Description from the page and returns it as a string.
  def assessment_type_description
    frm.div(:class=>"tier2").table(:index=>0)[2][1].text
  end

  # Clicks the Save Settings and Publish button
  # then instantiates the PublishAssessment class.
  def save_and_publish
    frm.button(:value=>"Save Settings and Publish").click
    PublishAssessment.new(@browser)
  end
  
  action(:open) { |b| b.frm.link(:text=>"Open") }
  action(:close) { |b| b.frm.link(:text=>"Close") }
  element(:title) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:intro:assessment_title") }
  element(:authors) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:intro:assessment_author") }
  element(:description) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:intro:_id44_textinput") }
  action(:add_attachments_to_intro) { |b| b.frm.button(:name=>"assessmentSettingsAction:intro:_id90").click }
  element(:available_date) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:startDate") }
  element(:due_date) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:endDate") }
  element(:retract_date) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:retractDate") }
  element(:released_to_anonymous) { |b| b.frm.radio(:name=>"assessmentSettingsAction:_id117") }
  element(:released_to_site) { |b| b.frm.radio(:name=>"assessmentSettingsAction:_id117") }
  element(:specified_ips) { |b| b.frm.text_field(:name=>"assessmentSettingsAction:_id132") }
  element(:secondary_id) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:username") }
  element(:secondary_pw) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:password") }
  element(:timed_assessment) { |b| b.frm.checkbox(:id=>"assessmentSettingsAction:selTimeAssess") }
  element(:limit_hour) { |b| b.frm.select(:id=>"assessmentSettingsAction:timedHours") }
  element(:limit_mins) { |b| b.frm.select(:id=>"assessmentSettingsAction:timedMinutes") }
  element(:linear_access) { |b| b.frm.radio(:name=>"assessmentSettingsAction:itemNavigation") }
  element(:random_access) { |b| b.frm.radio(:name=>"assessmentSettingsAction:itemNavigation") }
  element(:question_per_page) { |b| b.frm.radio(:name=>"assessmentSettingsAction:assessmentFormat") }
  element(:part_per_page) { |b| b.frm.radio(:name=>"assessmentSettingsAction:assessmentFormat") }
  element(:assessment_per_page) { |b| b.frm.radio(:name=>"assessmentSettingsAction:assessmentFormat") }
  element(:continuous_numbering) { |b| b.frm.radio(:name=>"assessmentSettingsAction:itemNumbering") }
  element(:restart_per_part) { |b| b.frm.radio(:name=>"assessmentSettingsAction:itemNumbering") }
  element(:add_mark_for_review) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:markForReview1") }
  element(:unlimited_submissions) { |b| b.frm.radio(:name=>"assessmentSettingsAction:unlimitedSubmissions") }
  element(:only_x_submissions) { |b| b.frm.radio(:name=>"assessmentSettingsAction:unlimitedSubmissions") }
  element(:allowed_submissions) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:submissions_Allowed") }
  element(:late_submissions_not_accepted) { |b| b.frm.radio(:name=>"assessmentSettingsAction:lateHandling") }
  element(:late_submissions_accepted) { |b| b.frm.radio(:name=>"assessmentSettingsAction:lateHandling") }
  element(:submission_message) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:_id245_textinput") }
  element(:final_page_url) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:finalPageUrl") }
  element(:question_level_feedback) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackAuthoring") }
  element(:selection_level_feedback) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackAuthoring") }
  element(:both_feedback_levels) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackAuthoring") }
  element(:immediate_feedback) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackDelivery") }
  element(:feedback_on_submission) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackDelivery") }
  element(:no_feedback) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackDelivery") }
  element(:feedback_on_date) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackDelivery") }
  element(:feedback_date) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackDate") }
  element(:only_release_scores) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackComponentOption") }
  element(:release_questions_and) { |b| b.frm.radio(:name=>"assessmentSettingsAction:feedbackComponentOption") }
  element(:release_student_response) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox1") }
  element(:release_correct_response) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox3") }
  element(:release_students_assessment_scores) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox5") }
  element(:release_students_question_and_part_scores) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox7") }
  element(:release_question_level_feedback) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox2") }
  element(:release_selection_level_feedback) { |b| b.frm.text_field(:id=>"assessmentSettingsAction:feedbackCheckbox4") }
  element(:release_graders_comments) { |b| b.frm.checkbox(:id=>"assessmentSettingsAction:feedbackCheckbox6") }
  element(:release_statistics) { |b| b.frm.checkbox(:id=>"assessmentSettingsAction:feedbackCheckbox8") }
  element(:student_ids_seen) { |b| b.frm.radio(:name=>"assessmentSettingsAction:anonymousGrading1") }
  element(:anonymous_grading) { |b| b.frm.radio(:name=>"assessmentSettingsAction:anonymousGrading1") }
    #radio_button(:no_gradebook_options) { |b| b.frm.radio(:name=>"") }
    #radio_button(:grades_sent_to_gradebook) { |b| b.frm.radio(:name=>"") }
    #radio_button(:record_highest_score) { |b| b.frm.radio(:name=>"") }
    #radio_button(:record_last_score) { |b| b.frm.radio(:name=>"") }
    #radio_button(:background_color) { |b| b.frm.radio(:name=>"") }
    #text_field(:color_value, :id=>"") }
    #radio_button(:background_image) { |b| b.frm.radio(:name=>"") }
    #text_field(:image_name, :=>"") }
    #text_field(:keywords, :=>"") }
    #text_field(:objectives, :=>"") }
    #text_field(:rubrics, :=>"") }
    #checkbox(:record_metadata_for_questions, :=>"") }
  action(:save) { |b| b.frm.button(:name=>"assessmentSettingsAction:_id383").click }
  action(:cancel) { |b| b.frm.button(:name=>"assessmentSettingsAction:_id385").click }

end

# Instructor's view of Students' assessment scores
class AssessmentTotalScores < BasePage

  frame_element

  # Gets the user ids listed in the
  # scores table, returns them as an Array
  # object.
  #
  # Note that this method is only appropriate when student
  # identities are not being obscured on this page. If student
  # submissions are set to be anonymous then this method will fail
  # to return any ids.
  def student_ids
    ids = []
    scores_table = frm.table(:id=>"editTotalResults:totalScoreTable").to_a
    scores_table.delete_at(0)
    scores_table.each { |row| ids << row[1] }
    return ids
  end

  # Adds a comment to the specified student's comment box.
  #
  # Note that this method assumes that the student identities are not being
  # obscured on this page. If they are, then this method will not work for
  # selecting the appropriate comment box.
  # @param student_id [String] the target student id
  # @param comment [String] the text of the comment being made to the student
  def comment_for_student(student_id, comment)
    index_val = student_ids.index(student_id)
    frm.text_field(:name=>"editTotalResults:totalScoreTable:#{index_val}:_id345").value=comment
  end

  # Clicks the Submit Date link in the table header to sort/reverse sort the list.
  def sort_by_submit_date
    frm.link(:text=>"Submit Date").click
  end

  # Enters the specified string into the topmost box listed on the page.
  #
  # This method is especially useful when the student identities are obscured, since
  # in that situation you can't target a specific student's comment box, obviously.
  # @param comment [String] the text to be entered into the Comment box
  def comment_in_first_box=(comment)
    frm.text_field(:name=>"editTotalResults:totalScoreTable:0:_id345").value=comment
  end

  # Clicks the Update button, then instantiates
  # the AssessmentTotalScores class.
  def update
    frm.button(:value=>"Update").click
    AssessmentTotalScores.new(@browser)
  end

  # Clicks the Assessments link on the page
  # then instantiates the AssessmentsList class.
  def assessments
    frm.link(:text=>"Assessments").click
    AssessmentsList.new(@browser)
  end

end

# The page that appears when you're creating a new quiz
# or editing an existing one
class EditAssessment < AssessmentsBase

  menu_bar_elements

  # Allows insertion of a question at a specified
  # point in the Assessment. Must include the
  # part number, the question number, and the type of
  # question. Question Type must match the Type
  # value in the drop down.
  def insert_question_after(part_num, question_num, qtype)
    if question_num.to_i == 0
      frm.select(:id=>"assesssmentForm:parts:#{part_num.to_i - 1}:changeQType").select(qtype)
    else
      frm.select(:id=>"assesssmentForm:parts:#{part_num.to_i - 1}:parts:#{question_num.to_i - 1}:changeQType").select(qtype)
    end
  end

  # Allows removal of question by part number and question number.
  # @param part_num [String] the Part number containing the question you want to remove
  # @param question_num [String] the number of the question you want to remove
  def remove_question(part_num, question_num)
    frm.link(:id=>"assesssmentForm:parts:#{part_num.to_i-1}:parts:#{question_num.to_i-1}:deleteitem").click
  end

  # Allows editing of a question by specifying its part number
  # and question number.
  # @param part_num [String] the Part number containing the question you want
  # @param question_num [String] the number of the question you want
  def edit_question(part_num, question_num)
    frm.link(:id=>"assesssmentForm:parts:#{part_num.to_i-1}:parts:#{question_num.to_i-1}:modify").click
  end

  # Allows copying an Assessment part to a Pool.
  # @param part_num [String] the part number of the assessment you want
  def copy_part_to_pool(part_num)
    frm.link(:id=>"assesssmentForm:parts:#{part_num.to_i-1}:copyToPool").click
  end

  # Allows removing a specified
  # Assessment part number.
  # @param part_num [String] the part number of the assessment you want
  def remove_part(part_num)
    frm.link(:xpath, "//a[contains(@onclick, 'assesssmentForm:parts:#{part_num.to_i-1}:copyToPool')]").click
  end

  # Clicks the Add Part button, then
  # instantiates the AddEditAssessmentPart page class.
  def add_part
    frm.link(:text=>"Add Part").click
    AddEditAssessmentPart.new(@browser)
  end

  # Selects the desired question type from the
  # drop down list.
  element(:question_type) { |b| b.frm.select(:id=>"assesssmentForm:changeQType").select(qtype) }

  # Clicks the Preview button,
  # then instantiates the PreviewOverview page class.
  def preview
    frm.link(:text=>"Preview").click
    PreviewOverview.new(@browser)
  end

  # Clicks the Settings link, then
  # instantiates the AssessmentSettings page class.
  def settings
    frm.link(:text=>"Settings").click
    AssessmentSettings.new(@browser)
  end

  # Clicks the Publish button, then
  # instantiates the PublishAssessment page class.
  def publish
    frm.link(:text=>"Publish").click
    PublishAssessment.new(@browser)
  end

  # Clicks the Question Pools button, then
  # instantiates the QuestionPoolsList page class.
  def question_pools
    frm.link(:text=>"Question Pools").click
    QuestionPoolsList.new(@browser)
  end

  # Allows retrieval of a specified question's
  # text, by part and question number.
  # @param part_num [String] the Part number containing the question you want
  # @param question_num [String] the number of the question you want
  def get_question_text(part_number, question_number)
    frm.table(:id=>"assesssmentForm:parts:#{part_number.to_i-1}:parts").div(:class=>"tier3", :index=>question_number.to_i-1).text
  end

  action(:print) { |b| b.frm.button(:text=>"Print").click }
  action(:update_points) { |b| b.frm.button(:id=>"assesssmentForm:pointsUpdate").click }

end

# This is the page for adding and editing a part of an assessment
class AddEditAssessmentPart < BasePage

  frame_element

  # Clicks the Save button, then instantiates
  # the EditAssessment page class.
  def save
    frm.button(:name=>"modifyPartForm:_id89").click
    EditAssessment.new(@browser)
  end

  element(:title) { |b| b.frm.text_field(:id=>"modifyPartForm:title") }
  element(:information) { |b| b.frm.text_field(:id=>"modifyPartForm:_id10_textinput") }
  action(:add_attachments) { |b| b.frm.button(:name=>"modifyPartForm:_id54").click }
  element(:questions_one_by_one) { |b| b.frm.radio(:index=>0, :name=>"modifyPartForm:_id60") }
  element(:random_draw) { |b| b.frm.radio(:index=>1, :name=>"modifyPartForm:_id60") }
  element(:pool_name) { |b| b.frm.select(:id=>"modifyPartForm:assignToPool") }
  element(:number_of_questions) { |b| b.frm.text_field(:id=>"modifyPartForm:numSelected") }
  element(:point_value_of_questions) { |b| b.frm.text_field(:id=>"modifyPartForm:numPointsRandom") }
  element(:negative_point_value) { |b| b.frm.text_field(:id=>"modifyPartForm:numDiscountRandom") }
  element(:randomized_each_time) { |b| b.frm.radio(:index=>0, :name=>"modifyPartForm:randomizationType") }
  element(:randomized_once) { |b| b.frm.radio(:index=>1, :name=>"modifyPartForm:randomizationType") }
  element(:order_as_listed) { |b| b.frm.radio(:index=>0, :name=>"modifyPartForm:_id81") }
  element(:random_within_part) { |b| b.frm.radio(:index=>1, :name=>"modifyPartForm:_id81") }
  element(:objective) { |b| b.frm.text_field(:id=>"modifyPartForm:obj") }
  element(:keyword) { |b| b.frm.text_field(:id=>"modifyPartForm:keyword") }
  element(:rubric) { |b| b.frm.text_field(:id=>"modifyPartForm:rubric") }
  action(:cancel) { |b| b.frm.button(:name=>"modifyPartForm:_id90").click }

end

# The review page once you've selected to Save and Publish
# the assessment
class PublishAssessment < BasePage

  frame_element
  # Clicks the Publish button, then
  # instantiates the AssessmentsList page class.
  def publish
    frm.button(:value=>"Publish").click
    AssessmentsList.new(@browser)
  end

  action(:cancel) { |b| b.frm.button(:value=>"Cancel").click }
  action(:edit) { |b| b.frm.button(:name=>"publishAssessmentForm:_id23").click }
  element(:notification) { |b| b.frm.select(:id=>"publishAssessmentForm:number") }

end

# The page for setting up a multiple choice question
class MultipleChoice < AssessmentsBase

  menu_bar_elements
  question_page_elements

  action(:whats_this) { |b| b.frm.link(:text=>"(What's This?)").click }
  element(:single_correct) { |b| b.frm.radio(:name=>"itemForm:chooseAnswerTypeForMC", :index=>0) }
  element(:enable_negative_marking) { |b| b.frm.radio(:name=>"itemForm:partialCreadit_NegativeMarking", :index=>0) }

    # Element present when negative marking selected:
  element(:negative_point_value) { |b| b.frm.text_field(:id=>"itemForm:answerdsc") }

  element(:enable_partial_credit) { |b| b.frm.radio(:name=>"itemForm:partialCreadit_NegativeMarking", :index=>1) }
  action(:reset_to_default) { |b| b.frm.link(:text=>"Reset to Default Grading Logic").click }
  element(:multi_single) { |b| b.frm.radio(:name=>"itemForm:chooseAnswerTypeForMC", :index=>1) }
  element(:multi_multi) { |b| b.frm.radio(:name=>"itemForm:chooseAnswerTypeForMC", :index=>2) }

  element(:answer_a) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:0:_id140_textinput") }
  action(:remove_a) { |b| b.frm.link(:id=>"itemForm:mcchoices:0:removelinkSingle").click }
  element(:answer_b) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:1:_id140_textinput") }
  action(:remove_b) { |b| b.frm.link(:id=>"itemForm:mcchoices:1:removelinkSingle").click }
  element(:answer_c) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:2:_id140_textinput") }
  action(:remove_c) { |b| b.frm.link(:id=>"itemForm:mcchoices:2:removelinkSingle").click }
  element(:answer_d) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:3:_id140_textinput") }
  action(:remove_d) { |b| b.frm.link(:id=>"itemForm:mcchoices:3:removelinkSingle").click }

    # Radio buttons that appear when "single correct" is selected
  element(:a_correct) { |b| b.frm.radio(:name=>"itemForm:mcchoices:0:mcradiobtn") }
  element(:b_correct) { |b| b.frm.radio(:name=>"itemForm:mcchoices:1:mcradiobtn") }
  element(:c_correct) { |b| b.frm.radio(:name=>"itemForm:mcchoices:2:mcradiobtn") }
  element(:d_correct) { |b| b.frm.radio(:name=>"itemForm:mcchoices:3:mcradiobtn") }

    # % Value fields that appear when "single correct" and "partial credit" selected
  element(:a_value) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:0:partialCredit") }
  element(:b_value) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:1:partialCredit") }
  element(:c_value) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:2:partialCredit") }
  element(:d_value) { |b| b.frm.text_field(:id=>"itemForm:mcchoices:3:partialCredit") }

  action(:reset_score_values) { |b| b.frm.link(:text=>"Reset Score Values").click }

    # Checkboxes that appear when "multiple correct" is selected
  element(:check_a_correct) { |b| b.frm.checkbox(:name=>"itemForm:mcchoices:0:mccheckboxes") }
  element(:check_b_correct) { |b| b.frm.checkbox(:name=>"itemForm:mcchoices:1:mccheckboxes") }
  element(:check_c_correct) { |b| b.frm.checkbox(:name=>"itemForm:mcchoices:2:mccheckboxes") }
  element(:check_d_correct) { |b| b.frm.checkbox(:name=>"itemForm:mcchoices:3:mccheckboxes") }

  element(:insert_additional_answers) { |b| b.frm.select(:id=>"itemForm:insertAdditionalAnswerSelectMenu") }
  element(:randomize_answers_yes) { |b| b.frm.radio(:index=>0, :name=>"itemForm:_id162") }
  element(:randomize_answers_no) { |b| b.frm.radio(:index=>1, :name=>"itemForm:_id162") }
  element(:require_rationale_yes) { |b| b.frm.radio(:index=>0, :name=>"itemForm:_id166") }
  element(:require_rationale_no) { |b| b.frm.radio(:index=>1, :name=>"itemForm:_id166") }

end

# The page for setting up a Survey question
class Survey < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:yes_no) { |b| b.frm.radio(:index=>0, :name=>"itemForm:selectscale") }
  element(:disagree_agree) { |b| b.frm.radio(:index=>1, :name=>"itemForm:selectscale") }
  element(:disagree_undecided) { |b| b.frm.radio(:index=>2, :name=>"itemForm:selectscale") }
  element(:below_above) { |b| b.frm.radio(:index=>3, :name=>"itemForm:selectscale") }
  element(:strongly_agree) { |b| b.frm.radio(:index=>4, :name=>"itemForm:selectscale") }
  element(:unacceptable_excellent) { |b| b.frm.radio(:index=>5, :name=>"itemForm:selectscale") }
  element(:one_to_five) { |b| b.frm.radio(:index=>6, :name=>"itemForm:selectscale") }
  element(:one_to_ten) { |b| b.frm.radio(:index=>7, :name=>"itemForm:selectscale") }

end

#  The page for setting up a Short Answer/Essay question
class ShortAnswer < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:model_short_answer) { |b| b.frm.text_field(:id=>"itemForm:_id129_textinput") }

end

#  The page for setting up a Fill-in-the-blank question
class FillInBlank < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:case_sensitive) { |b| b.frm.checkbox(:name=>"itemForm:_id76") }
  element(:mutually_exclusive) { |b| b.frm.checkbox(:name=>"itemForm:_id78") }

end

#  The page for setting up a numeric response question
class NumericResponse < AssessmentsBase

  menu_bar_elements
  question_page_elements

end

#  The page for setting up a matching question
class Matching < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:choice) { |b| b.frm.text_field(:id=>"itemForm:_id147_textinput") }
  element(:match) { |b| b.frm.text_field(:id=>"itemForm:_id151_textinput") }
  action(:save_pairing) { |b| b.frm.button(:name=>"itemForm:_id164").click }

end

#  The page for setting up a True/False question
class TrueFalse < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:negative_point_value) { |b| b.frm.text_field(:id=>"itemForm:answerdsc") }
  element(:answer_true) { |b| b.frm.radio(:index=>0, :name=>"itemForm:TF") }
  element(:answer_false) { |b| b.frm.radio(:index=>1, :name=>"itemForm:TF") }
  element(:required_rationale_yes) { |b| b.frm.radio(:index=>0, :name=>"itemForm:rational") }
  element(:required_rationale_no) { |b| b.frm.radio(:index=>1, :name=>"itemForm:rational") }

end

#  The page for setting up a question that requires an audio response
class AudioRecording < AssessmentsBase

  menu_bar_elements
  question_page_elements

  element(:time_allowed) { |b| b.frm.text_field(:id=>"itemForm:timeallowed") }
  element(:number_of_attempts) { |b| b.frm.select(:id=>"itemForm:noattempts") }

end

# The page for setting up a question that requires
# attaching a file
class FileUpload < AssessmentsBase

  menu_bar_elements
  question_page_elements

end

# The page that appears when you are editing a type of assessment
class EditAssessmentType < AssessmentsBase


end

# The Page that appears when adding a new question pool
class AddQuestionPool < AssessmentsBase

  pool_page_elements

end

# The Page that appears when editing an existing question pool
class EditQuestionPool < AssessmentsBase

  pool_page_elements

  # Clicks the Add Question link, then
  # instantiates the SelectQuestionType class.
  def add_question
    frm.link(:id=>"editform:addQlink").click
    SelectQuestionType.new(@browser)
  end

  # Clicks the Question Pools link, then
  # instantiates the QuestionPoolsList class.
  def question_pools
    frm.link(:text=>"Question Pools").click
    QuestionPoolsList.new(@browser)
  end

  action(:update) { |b| b.frm.button(:id=>"editform:Update").click }

end

# The page with the list of existing Question Pools
class QuestionPoolsList < AssessmentsBase

  # Clicks the edit button, next is
  # the EditQuestionPool page class.
  # @param name [String] the name of the pool you want to edit
  def edit_pool(name)
    frm.span(:text=>name).fire_event("onclick")
  end

  # Clicks the Add New Pool link, then
  # instantiates the AddQuestionPool page class.
  def add_new_pool
    #puts "clicking add new pool..."
    #10.times {frm.link(:text=>"Add New Pool").flash}
    frm.link(:text=>"Add New Pool").click
    #puts "clicked..."
    #frm.text_field(:id=>"questionpool:namefield").wait_until_present(200)
    AddQuestionPool.new(@browser)
  end

  # Returns an array containing strings of the pool names listed
  # on the page.
  def pool_names
    names= []
    frm.table(:id=>"questionpool:TreeTable").rows.each do | row |
      if row.span(:id=>/questionpool.+poolnametext/).exist?
        names << row.span(:id=>/questionpool.+poolnametext/).text
      end
    end
    return names
  end

  # Clicks "Import" and then instantiates the
  # PoolImport page class.
  def import
    frm.link(:text=>"Import").click
    PoolImport.new(@browser)
  end

  # Clicks the Assessments link and then
  # instantiates the AssessmentsList page class.
  def assessments
    frm.link(:text=>"Assessments").click
    AssessmentsList.new(@browser)
  end

end

# The page that appears when you click to import
# a pool.
class PoolImport < AssessmentsBase

  # Enters the target file into the Choose File
  # file field. Including the file path separately is optional.
  # @param file_name [String] the name of the file you want to choose. Can include path info, if desired.
  # @param file_path [String] Optional. This is the path information for the file location.
  def choose_file(file_name, file_path="")
    frm.file_field(:name=>"importPoolForm:_id6.upload").set(file_path + file_name)
  end

  # Clicks the Import button, then
  # instantiates the QuestionPoolsList
  # page class.
  def import
    frm.button(:value=>"Import").click
    QuestionPoolsList.new(@browser)
  end

end

# This page appears when adding a question to a pool
class SelectQuestionType < AssessmentsBase

  # Selects the specified question type from the
  # drop-down list, then instantiates the appropriate
  # page class, based on the question type selected.
  # @param qtype [String] the text of the question type you want to select from the drop down list.
  def select_question_type(qtype)
    frm.select(:id=>"_id1:selType").select(qtype)
    frm.button(:value=>"Save").click
  end

  action(:cancel) { |b| b.frm.button(:value=>"Cancel").click }

end

# Page of Assessments accessible to a student user
#
# It may be that we want to deprecate this class and simply use
# the AssessmentsList class alone.
class TakeAssessmentList < AssessmentsBase

  # Returns an array containing the assessment names that appear on the page.
  def available_assessments
    # define this later
  end

  # Method to get the titles of assessments that
  # the student user has submitted. The titles are
  # returned in an Array object.
  def submitted_assessments
    table_array = @browser.frame(:index=>1).table(:id=>"selectIndexForm:reviewTable").to_a
    table_array.delete_at(0)
    titles = []
    table_array.each { |row|
      unless row[0] == ""
        titles << row[0]
      end
    }

    return titles

  end

  # Clicks the specified assessment
  # then instantiates the BeginAssessment
  # page class.
  # @param name [String] the name of the assessment you want to take
  def take_assessment(name)
    begin
      frm.link(:text=>name).click
    rescue Watir::Exception::UnknownObjectException
      frm.link(:text=>CGI::escapeHTML(name)).click
    end
    BeginAssessment.new(@browser)
  end

  # TODO This method is in need of improvement to make it more generalized for finding the correct test.
  #
  def feedback(test_name)
    test_table = frm.table(:id=>"selectIndexForm:reviewTable").to_a
    test_table.delete_if { |row| row[3] != "Immediate" }
    index_value = test_table.index { |row| row[0] == test_name }
    frm.link(:text=>"Feedback", :index=>index_value).click
    # Need to add a call to a New class here, when it's written
  end

end

# The student view of the overview page of an Assessment
class BeginAssessment < AssessmentsBase

  # Clicks the Begin Assessment button.
  def begin_assessment
    frm.button(:value=>"Begin Assessment").click
  end

  # Clicks the Cancel button and instantiates the X Class.
  def cancel
    # Define this later
  end

  # Selects the specified radio button answer
  def multiple_choice_answer(letter)
    # TODO: Convert this to a hash instead of case statement
    index = case(letter.upcase)
              when "A" then "0"
              when "B" then "1"
              when "C" then "2"
              when "D" then "3"
              when "E" then "4"
            end
    frm.radio(:name=>/takeAssessmentForm.+:deliverMultipleChoice.+:_id.+:#{index}/).click
  end

  # Enters the answer into the specified blank number (1-based).
  # @param answer [String]
  def fill_in_blank_answer(answer, blank_number)
    index = blank_number.to_i-1
    frm.text_field(:name=>/deliverFillInTheBlank:_id.+:#{index}/).value=answer
  end

  # Clicks either the True or the False radio button, as specified.
  def true_false_answer(answer)
    answer.upcase=~/t/i ? index = 0 : index = 1
    frm.radio(:name=>/deliverTrueFalse/, :index=>index).set
  end

  # Enters the specified string into the Rationale text box.
  def true_false_rationale(text)
    frm.text_field(:name=>/:deliverTrueFalse:rationale/).value=text
  end

  # Enters the specified text into the "Short Answer" field.
  def short_answer(answer)
    frm.text_field(:name=>/deliverShortAnswer/).value=answer
  end

  # Selects the specified matching value, at the spot specified by the number (1-based counting).
  def match_answer(answer, number)
    index = number.to_i-1
    frm.select(:name=>/deliverMatching/, :index=>index).select(answer)
  end

  # Enters the specified file name in the file field. You can include the path to the file
  # as an optional second parameter.
  def file_answer(file_name, file_path="")
    frm.file_field(:name=>/deliverFileUpload/).set(file_path + file_name)
    frm.button(:value=>"Upload").click
  end

  # Clicks the Next button and instantiates the BeginAssessment Class.
  def next
    frm.button(:value=>"Next").click
    BeginAssessment.new(@browser)
  end

  # Clicks the Submit for Grading button and instantiates the ConfirmSubmission Class.
  def submit_for_grading
    frm.button(:value=>"Submit for Grading").click
    ConfirmSubmission.new(@browser)
  end
end

# The confirmation page that appears when submitting an Assessment.
# The last step before actually submitting the the Assessment.
class ConfirmSubmission < AssessmentsBase

  # Clicks the Submit for Grading button and instantiates
  # the SubmissionSummary Class.
  def submit_for_grading
    frm.button(:value=>"Submit for Grading").click
    SubmissionSummary.new(@browser)
  end
  
  value(:validation) { |b| b.frm.span(:class=>"validation").text }

end

# The summary page that appears when an Assessment has been submitted.
class SubmissionSummary < AssessmentsBase

  # Clicks the Continue button and instantiates
  # the TakeAssessmentList Class.
  def continue
    frm.button(:value=>"Continue").click
    TakeAssessmentList.new(@browser)
  end

  value(:summary_info) { |b| b.frm.div(:class=>"tier1").text }

end
