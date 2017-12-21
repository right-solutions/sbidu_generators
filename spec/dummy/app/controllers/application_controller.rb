class ApplicationController < Kuppayam::BaseController

  include Usman::AuthenticationHelper

  layout 'kuppayam/admin'
  
  before_action :current_user
  helper_method :breadcrumb_home_path
    
  private

  def set_default_title
    set_title("Red Velvet Salon, Karama - The best salon in Dubai")
  end

  def breadcrumb_home_path
    main_app.dashboard_path
  end
  
end
