Rails.application.routes.draw do
  
  mount Usman::Engine => "/"
  mount Pattana::Engine => "/"
  mount Dhatu::Engine => "/"

  # Default Landing Page after successful signin
  get   '/landing', to: "landing#index",  as: :user_landing

  # Dashboard Page - Landing Page Redirects to this page
  get   '/dashboard',   to: "dashboard#index",  as:   :dashboard

  # Website Pages
  root  'website/home#index'

  get   '/about_us',      to: "website/about_us#index",  as: :about_us
  get   '/contact_us',    to: "website/contact_us#index", as: :contact_us

  get   '/blogs',         to: "website/blog#index",       as: :blogs
  get   '/blog/:slug',    to: "website/blog#show",        as: :blog

  get   '/services',      to: "website/services#index",   as: :services
  get   '/services/:id',  to: "website/services#show",   as: :service
  get   '/services/filter/:category_id',  to: "website/services#filter",    as: :filter_services

  get   '/products',      to: "website/products#index",   as: :products
  get   '/products/:id',  to: "website/products#show",   as: :product
  get   '/products/filter/:category_id',  to: "website/products#filter",    as: :filter_products

  get   '/projects',      to: "website/projects#index",   as: :projects
  get   '/projects/:id',  to: "website/projects#show",   as: :project
  get   '/projects/filter/:category_id',  to: "website/projects#filter",    as: :filter_projects
  
  get   '/careers',      to: "website/careers#index",   as: :careers  
  get   '/offers',        to: "website/offers#index",    as: :offers
  get   '/pricing',       to: "website/prices#index",    as: :prices
  
  post  '/booking/create',        to: "website/booking#create",   as:   :create_booking
  post  '/promotion_enquiries',   to: "website/promotion_enquiries#create",   as:   :promotion_enquiries
  
end