#===============
# Podcast pages
#================

#
class Podcasts < BasePage

  frame_element

  def add
    frm.link(:text=>"Add").click
    AddEditPodcast.new(@browser)
  end

  def podcast_titles
    titles = []
    frm.spans.each do |span|
      if span.class_name == "podTitleFormat"
        titles << span.text
      end
    end
    return titles
  end



end