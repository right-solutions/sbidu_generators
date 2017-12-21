class Website::OffersController < Website::BaseController

	layout 'website/theme'

	def index
		set_title("Red Velvet Salon, Karama - The best salon in Dubai")
		@offers = Dhatu::Offer.published.order("priority ASC, title ASC").page(@current_page).per(@per_page)
		@price_categories = Dhatu::Category.filter_by_category_type("Dhatu::Price").published.order("priority ASC, name ASC").all
	end

	private

	def set_navs
  	set_nav("website/offers")  
  end
	
end
