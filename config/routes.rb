Rails.application.routes.draw do
  #api.market_place_api.dev
  #using namespace directory remains the part of the url but with constrainst now its 
  #a subdomin
  namespace :api, defaults: {format: :json}, constraints: { subdomain: 'api', path: '/'} do
    #api.market_place_api.dev/products
    #using module directory skipped in path of resorce=s under directory
    scope module: :v1 do
      
    end
  end
end
