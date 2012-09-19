#================
# Job Scheduler pages in Admin Workspace
#================

# The topmost page in the Job Scheduler in Admin Workspace
class JobScheduler < BasePage

  frame_element

  # Clicks the Jobs link, then instantiates
  # the JobList Class.
  def jobs
    frm.link(:text=>"Jobs").click
    JobList.new(@browser)
  end

end

# The list of Jobs (click the Jobs button on Job Scheduler)
class JobList < BasePage

  frame_element

  # Clicks the New Job link, then
  # instantiates the CreateNewJob Class.
  def new_job
    frm.link(:text=>"New Job").click
    CreateNewJob.new(@browser)
  end

  # Clicks the link with the text "Triggers" associated with the
  # specified job name, 
  # then instantiates the EditTriggers Class.
  def triggers(job_name)
    frm.div(:class=>"portletBody").table(:class=>"listHier lines").row(:text=>/#{Regexp.escape(job_name)}/).link(:text=>/Triggers/).click
    sleep 1
    EditTriggers.new(@browser)
  end

  def event_log
    frm.link(:text=>"Event Log").click
    EventLog.new(@browser)
  end

end

# The Create New Job page
class CreateNewJob < BasePage

  frame_element

  # Clicks the Post button, then
  # instantiates the JobList Class.
  def post
    frm.button(:value=>"Post").click
    JobList.new(@browser)
  end

  element(:job_name) { |b| b.frm.text_field(:id=>"_id2:job_name") }
  element(:type) { |b| b.frm.select_list(:name=>"_id2:_id10") }
end

# The page for Editing Triggers
class EditTriggers < BasePage

  frame_element

  # Clicks the "Run Job Now" link, then
  # instantiates the RunJobConfirmation Class.
  def run_job_now
    frm.div(:class=>"portletBody").link(:text=>"Run Job Now").click
    RunJobConfirmation.new(@browser)
  end

  def return_to_jobs
    frm.link(:text=>"Return_to_Jobs").click
    JobList.new(@browser)
  end

  def new_trigger
    frm.link(:text=>"New Trigger").click
    CreateTrigger.new(@browser)
  end

end

# The Create Trigger page
class CreateTrigger < BasePage

  frame_element

  def post
    frm.button(:value=>"Post").click
    EditTriggers.new(@browser)
  end

  element(:name) { |b| b.frm.text_field(:id=>"_id2:trigger_name") }
  element(:cron_expression) { |b| b.frm.text_field(:id=>"_id2:trigger_expression") }
end


# The page for confirming you want to run a job
class RunJobConfirmation < BasePage

  frame_element

  # Clicks the "Run Now" button, then
  # instantiates the JobList Class.
  def run_now
    frm.button(:value=>"Run Now").click
    JobList.new(@browser)
  end

end

# The page containing the Event Log
class EventLog < BasePage

  frame_element

end