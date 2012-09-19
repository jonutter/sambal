
# The page where you search for public courses and projects.
class SearchPublic < BasePage

  frame_element

  def home
    @browser.frame(:index=>0).link(:text=>"Home").click
    Login.new(@browser)
  end

  def search_for=(string)
    @browser.frame(:index=>0).text_field(:id=>"searchbox").set(Regexp.escape(string))
  end

  def search_for_sites
    @browser.frame(:index=>0).button(:value=>"Search for Sites").click
    SearchPublicResults.new(@browser)
  end

end

# The page showing the results list of Site matches to a search of public sites/projects.
class SearchPublicResults < BasePage

  frame_element

  def click_site(site_name)
    @browser.frame(:index=>0).link(:text=>site_name).click
    SiteSummaryPage.new(@browser)
  end

  def home
    @browser.frame(:id=>"ifrm").link(:text=>"Home").click
    Login.new(@browser)
  end

end

# The page that appears when you click a Site in the Site Search Results page, when not logged
# in to Sakai.
class SiteSummaryPage < BasePage

  frame_element

  def return_to_list
    @browser.frame(:index=>0).button(:value=>"Return to List").click
    SearchPublicResults.new(@browser)
  end

  def syllabus_attachments
    links = []
    @browser.frame(:id=>"ifrm").links.each do |link|
      if link.href=~/Syllabus/
        links << link.text
      end
    end
    return links
  end

end