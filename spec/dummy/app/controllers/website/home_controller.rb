class Website::HomeController < Website::BaseController

  layout 'website/theme'

  def index
    # @slider_sections = Dhatu::Section.find_by_code("HOME_PAGE_SLIDE").published.all
  end

  private

  def set_navs
    set_nav("website/home")
  end
  
end
