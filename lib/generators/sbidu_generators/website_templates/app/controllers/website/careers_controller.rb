class Website::AboutUsController < Website::BaseController

	layout "website/theme"

	def index
		@banner = Dhatu::Section.find_by_code("CAREERS_BANNER").published.first
	end

	private

	def set_navs
    set_nav("website/about_us")
  end
	
end
