module AssignmentsFrame

  include PageObject
  include GlobalMethods
  include HeaderFooterBar
  include LeftMenuBar
  include HeaderBar
  include DocButtons

  # The frame object that contains all of the CLE Tests and Quizzes objects
  def frm
    self.frame(:src=>/sakai2assignments.launch.html/)
  end

end

#
class AssignmentsList
  include AssignmentsFrame
  include  AssignmentsListMethods
end

#
class AssignmentAdd
  include AssignmentsFrame
  include  AssignmentAddMethods
end

#
class AssignmentsPermissions
  include AssignmentsFrame
  include  AssignmentsPermissionsMethods
end

#
class AssignmentsPreview
  include AssignmentsFrame
  include  AssignmentsPreviewMethods
end

#
class AssignmentsReorder
  include AssignmentsFrame
  include  AssignmentsReorderMethods
end

#
class AssignmentStudent
  include AssignmentsFrame
  include  AssignmentStudentMethods
end

#
class AssignmentStudentPreview
  include AssignmentsFrame
  include AssignmentStudentPreviewMethods
end

#
class SubmissionConfirmation
  include AssignmentsFrame
  include SubmissionConfirmationMethods
end

#
class AssignmentSubmissionList
  include AssignmentsFrame
  include  AssignmentSubmissionListMethods
end

#
class AssignmentSubmission
  include AssignmentsFrame
  include  AssignmentSubmissionMethods
end

#
class GradeReport
  include AssignmentsFrame
  include GradeReportMethods
end

#
class StudentView
  include AssignmentsFrame
  include  StudentViewMethods
end