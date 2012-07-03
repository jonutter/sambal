module Profile2Frame
  include GlobalMethods
  include HeaderFooterBar
  include LeftMenuBar
  include HeaderBar
  include DocButtons

  # The frame object that contains all of the CLE Tests and Quizzes objects
  def frm
    self.frame(:src=>/TBD/)
  end

end

#
class Profile2
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2Methods
end

#
class Profile2Preferences
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2PreferencesMethods
end

class Profile2Privacy
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2PrivacyMethods
end

class Profile2Search
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2SearchMethods
end

class Profile2Connections
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2ConnectionsMethods
end

class Profile2View
  include PageObject
  include Profile2Frame
  include Profile2Nav
  include Profile2ViewMethods
end