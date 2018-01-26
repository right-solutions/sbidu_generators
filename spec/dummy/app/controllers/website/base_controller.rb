class Website::BaseController < ApplicationController
  
  layout 'website/home'

  before_action :get_page, :get_general_data
                
  before_action :set_meta_title, if: -> { @page }

  # before_action :get_promotion, 
  #               :configure_popup, 
  #               :set_show_book_now_form
  
  private

  def stylesheet_filename
    @stylesheet_filename = "starter_kit"
  end

  def javascript_filename
    @javascript_filename = "starter_kit"
  end

  def set_meta_title
    # Setting Dynamic Title from Dhatu::MetaTag
    if @page
      meta_tag_title = @page.meta_tags.published.where("meta_key = 'title'").first
      set_title(meta_tag_title.meta_value) if meta_tag_title
    end
  end

  # Get Data to make things Dynamic
  # -------------------------------

  def get_page
    @page = Dhatu::Page.find_by_code("home-page")
  end

  def get_general_data
    # Put Code to fetch generic data.
    # Refer the given examples
    # @footer_section = Dhatu::Section.find_by_code("ABOUT_US_FOOTER").published.first
    # @book_now_section = Dhatu::Section.find_by_code("BOOK_NOW").published.first
    # @main_branch = Dhatu::Branch.published.main_branch.first
    # @service_categories = Dhatu::Category.where("category_type = 'Dhatu::Service'").published.all
  end

  # Promotion Methods
  # -----------------

  def get_promotion
    @promotion = Dhatu::Promotion.published.first
  end

  def configure_popup
    @show_popup = true
    if @promotion
      @show_popup = false and return unless @promotion.show_popup
      @show_popup = false and return if @promotion.show_only_on_homepage and params["controller"] != "website/home"
      if @promotion.popup_lifespan_in_minutes > 0
        cookie_name = "popup-#{@promotion.id}"
        @show_popup = false and return if cookies[cookie_name] && cookies[cookie_name].to_s == "#{@promotion.updated_at.to_i}"
        i = @promotion.popup_lifespan_in_minutes.to_i
        cookies[cookie_name] = { :value => "#{@promotion.updated_at.to_i}", :expires => i.hours.from_now }
      end
    else
      @show_popup = false and return
    end
  end

  def set_show_book_now_form
    @show_book_now_form = true
  end
  
end
