class Website::AboutUsController < Website::BaseController

	layout "website/theme"

	def index
		@banner = Dhatu::Section.find_by_code("ABOUT_US_BANNER").published.first
		@about_us = Dhatu::Section.find_by_code("ABOUT_US_DETAILED").published.first
		@vision = Dhatu::Section.find_by_code("OUR_VISION").published.first
		@mission = Dhatu::Section.find_by_code("OUR_MISSION").published.first
	end

	private

	def set_navs
    set_nav("website/about_us")
  end
	
end
