class Website::HomeController < Website::BaseController

	layout 'website/theme'

	def index
	end

	private

	def set_navs
    set_nav("website/home")
  end
	
end
