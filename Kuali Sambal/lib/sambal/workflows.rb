# Helper methods that don't properly belong elsewhere. This is
# a sort of "catch all" Module.
module Workflows

  # Site Navigation helpers...
  def go_to_create_population
    visit MainMenu do |page|
      page.population_maintenance_edoc
    end
  end

  def go_to_manage_population
    visit MainMenu do |page|
      page.manage_population
    end
  end

  def go_to_manage_course_offerings
    visit MainMenu do |page|
      page.manage_course_offerings
    end
  end

  # Helper methods...
  def logged_in?
    logged_in = "Ramble On"
    on Header do |page|
      logged_in = page.main_menu_el.present?
    end
    logged_in
  end

  def logged_in_user
    user = ""
    on Header do |page|
      begin
        user = page.logged_in_user
      rescue Watir::Exception::UnknownObjectException
        user = "No One"
      end
    end
    user
  end

  def log_in(user, pwd)
    visit Login do |page|
      page.login_with user, pwd
    end
  end

end