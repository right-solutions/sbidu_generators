class Website::BaseController < ApplicationController
  
  layout 'website/home'

  private

  def set_navs
    set_nav("website/home")
  end

  def stylesheet_filename
    @stylesheet_filename = "starter_kit"
  end

  def javascript_filename
    @javascript_filename = "starter_kit"
  end
  
end
