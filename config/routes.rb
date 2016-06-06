require 'api_constraints'
Rails.application.routes.draw do
  devise_for :users
  #api.market_place_api.dev
  #using namespace directory remains the part of the url but with constrainst now its 
  #a subdomin
  namespace :api, defaults: {format: :json}, constraints: { subdomain: 'api', path: '/'} do
    #api.market_place_api.dev/products
    #using module directory skipped in path of resorce=s under directory
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy]    
    end
  end
end
