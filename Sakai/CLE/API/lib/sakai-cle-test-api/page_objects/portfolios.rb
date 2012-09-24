#================
# Portfolios pages
#================

#
class Portfolios < BasePage

  frame_element

  def create_new_portfolio
    frm.link(:text=>"Create New Portfolio").click
    AddPortfolio.new(@browser)
  end

  def list
    list = []
    frm.table(:class=>"listHier ospTable").rows.each do |row|
      list << row[0].text
    end
    list.delete_at(0)
    return list
  end

  def shared(portfolio_name)
    frm.table(:class=>"listHier ospTable").row(:text=>/#{Regexp.escape(portfolio_name)}/)[5].text
  end



end

#
class AddPortfolio < BasePage

  frame_element

  def create
    frm.button(:value=>"Create").click
    EditPortfolio.new(@browser)
  end


  element(:name) { |b| b.frm.text_field(:name=>"presentationName") }
  element(:design_your_own_portfolio) { |b| b.frm.radio(:id=>"templateId-freeForm") }

end

#
class EditPortfolio < BasePage

  frame_element

  def add_edit_content
    frm.link(:text=>"Add/Edit Content").click
    AddEditPortfolioContent.new @browser
  end


  action(:edit_title) { |b| b.frm.link(:text=>"Edit Title").click }
  action(:save_changes) { |b| b.frm.link(:text=>"Save Changes").click }
  element(:active) { |b| b.frm.radio(:id=>"btnActive") }
  element(:inactive) { |b| b.frm.radio(:id=>"btnInactive") }

end

#
class AddEditPortfolioContent < BasePage

  frame_element

  def add_page
    frm.link(:text=>"Add Page").click
    AddEditPortfolioPage.new(@browser)
  end

  def share_with_others
    frm.link(:text=>"Share with Others").click
    SharePortfolio.new @browser
  end


  action(:save_changes) { |b| b.frm.button(:value=>"Save Changes").click }

end

#
class AddEditPortfolioPage < BasePage

  frame_element

  def add_page
    frm.button(:value=>"Add Page").click
    AddEditPortfolioContent.new(@browser)
  end

  def select_layout
    frm.link(:text=>"Select Layout").click
    ManagePortfolioLayouts.new @browser
  end

  def select_style
    frm.link(:text=>"Select Style").click
    SelectPortfolioStyle.new @browser
  end

  def simple_html_content=(text)
    frm.frame(:id, "_id1:arrange:_id49_inputRichText___Frame").div(:title=>"Select All").fire_event("onclick")
    frm.frame(:id, "_id1:arrange:_id49_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys :backspace
    frm.frame(:id, "_id1:arrange:_id49_inputRichText___Frame").td(:id, "xEditingArea").frame(:index=>0).send_keys(text)
  end


  element(:title) { |b| b.frm.text_field(:id=>"_id1:title") }
  element(:description) { |b| b.frm.text_field(:id=>"_id1:description") }
  element(:keywords) { |b| b.frm.text_field(:id=>"_id1:keywords") }


end

#
class ManagePortfolioLayouts < BasePage

  frame_element

  def select(layout_name)
    frm.table(:class=>"listHier lines nolines").row(:text=>/#{Regexp.escape(layout_name)}/).link(:text=>"Select").click
    AddEditPortfolioPage.new @browser
  end

  def go_back
    frm.button(:value=>"Go Back").click
    AddEditPortfolioPage.new @browser
  end

end

#
class SharePortfolio < BasePage

  frame_element

  def click_here_to_share_with_others
    frm.link(:text=>"Click here to share with others").click
    AddPeopleToShare.new(@browser)
  end

  def summary
    frm.link(:text=>"Summary").click
    EditPortfolio.new @browser
  end


  element(:everyone_on_the_internet) { |b| b.frm.checkbox(:id=>"public_checkbox") }

end

#
class AddPeopleToShare < BasePage

  frame_element

end