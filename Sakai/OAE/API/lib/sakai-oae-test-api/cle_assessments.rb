# TODO - describe class
module AssessmentsFrame

  include PageObject
  include GlobalMethods
  include HeaderFooterBar
  include LeftMenuBar
  include HeaderBar
  include DocButtons

  # The frame object that contains all of the CLE Tests and Quizzes objects
  def frm
    self.frame(:src=>/sakai2samigo.launch.html/)
  end

end

class AssessmentsList
  include AssessmentsFrame
  include AssessmentsListMethods
end

class PreviewOverview
  include AssessmentsFrame
  include PreviewOverviewMethods
end

class AssessmentSettings
  include AssessmentsFrame
  include AssessmentSettingsMethods
end

class AssessmentTotalScores
  include AssessmentsFrame
  include AssessmentTotalScoresMethods
end

class EditAssessment
  include AssessmentsFrame
  include EditAssessmentMethods
end

class AddEditAssessmentPart
  include AssessmentsFrame
  include AddEditAssessmentPartMethods
end

class PublishAssessment
  include AssessmentsFrame
  include PublishAssessmentMethods
end

class MultipleChoice
  include AssessmentsFrame
  include MultipleChoiceMethods
end

class Survey
  include AssessmentsFrame
  include SurveyMethods
end

class ShortAnswer
  include AssessmentsFrame
  include ShortAnswerMethods
end

class FillInBlank
  include AssessmentsFrame
  include FillInBlankMethods
end

class NumericResponse
  include AssessmentsFrame
  include NumericResponseMethods
end

class Matching
  include AssessmentsFrame
  include MatchingMethods
end

class TrueFalse
  include AssessmentsFrame
  include TrueFalseMethods
end

class AudioRecording
  include AssessmentsFrame
  include AudioRecordingMethods
end

class FileUpload
  include AssessmentsFrame
  include FileUploadMethods
end

class EditAssessmentType
  include AssessmentsFrame
  include EditAssessmentTypeMethods
end

class AddQuestionPool
  include AssessmentsFrame
  include AddQuestionPoolMethods
end

class EditQuestionPool
  include AssessmentsFrame
  include EditQuestionPoolMethods
end

class QuestionPoolsList
  include AssessmentsFrame
  include QuestionPoolsListMethods
end

class PoolImport
  include AssessmentsFrame
  include PoolImportMethods
end

class SelectQuestionType
  include AssessmentsFrame
  include SelectQuestionTypeMethods
end

class TakeAssessmentList
  include AssessmentsFrame
  include TakeAssessmentListMethods
end

class BeginAssessment
  include AssessmentsFrame
  include BeginAssessmentMethods
end

class ConfirmSubmission
  include AssessmentsFrame
  include ConfirmSubmissionMethods
end

class SubmissionSummary
  include AssessmentsFrame
  include SubmissionSummaryMethods
end