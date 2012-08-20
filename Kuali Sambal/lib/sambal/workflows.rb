# This module contains methods that exist in a grey, nebulous middle zone...
# They aren't quite step definitions, but they involve multiple
# page classes.
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

  # Larger flows...



end