Rails.application.routes.draw do
  devise_for :org_people, :controllers => { 
    :registrations => "org_people/registrations",
    :sessions => "org_people/sessions",
    :passwords => "org_people/passwords" , 
    :confirmations => "org_people/confirmations" }
  devise_scope :org_person do 
    get 'signup',  to: 'org_people/registrations#new'
    get 'signin',  to: 'org_people/sessions#new'
    delete 'signout', to: 'org_people/sessions#destroy'
  end


  post 'carts/add/' => 'carts#add', :to => 'carts_add'

  get 'org_companies/:id/company_profile' => 'org_companies#company_profile', :as => 'org_companies_company_profile'
  get 'org_companies/people/' => 'org_companies#people', :to => "org_companies_people"
  
  post 'org_products/delivery_status/' => 'org_products#delivery_status', :to => "org_products_delivery_status"
  post 'org_products/vote_product/' => 'org_products#vote_product', :to => "org_products_vote_product"
  get 'org_products/orders/' => 'org_products#orders', :to => "org_products_orders" 
  get 'org_products/completed_orders/' => 'org_products#completed_orders', :to => "org_products_completed_orders"

  get 'org_people/stripe_settings/' => 'org_people#stripe_settings', :to => "org_people_stripe_settings"
  post 'org_people/stripe_update_settings/' => 'org_people#stripe_update_settings', :to => "org_people_stripe_update_settings"
  post 'org_people/edit_position/' => 'org_people#edit_position', :to => "org_people_edit_position"
  post 'org_people/remove_from_company/' => 'org_people#remove_from_company', :to => "org_people_remove_from_company"

  post 'trx_orders/stripe/' => 'trx_orders#stripe', :to =>"trx_orders_stripe"
  get 'trx_orders/stripe_success/:id' => 'trx_orders#stripe_success', :to => "trx_orders_stripe_success"
  get 'trx_orders/list_purchases/' => 'trx_orders#list_purchases', :to => "trx_orders_list_purchases"
  get 'trx_orders/list_personal_purchases/' => 'trx_orders#list_personal_purchases', :to => "trx_orders_list_personal_purchases"
  get 'trx_orders/purchase_order/' => 'trx_orders#purchase_order', :to => "trx_orders_purchase_order"

  # - Stripe routes
  # - Create accounts
  post '/connect/managed' => 'stripe#managed', as: 'stripe_managed'
  # Stripe webhooks
  post '/hooks/stripe' => 'hooks#stripe'


  post 'trx_orders/hook' => 'trx_orders#hook', :to => "trx_orders_hook"


  resources :carts
  resources :catalogues
  resources :org_people
  resources :org_companies
  resources :org_products
  resources :trx_orders
  resources :sessions, only: [:new, :create, :destroy]
  root "catalogues#index"

  match '/org_register', to:'org_companies#new', via: 'get'
end