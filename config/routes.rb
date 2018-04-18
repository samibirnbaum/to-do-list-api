Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users
  end
end


# Prefix Verb   URI Pattern                                  Controller#Action
# api_users GET    /api/users(.:format)                      api/users#index {:format=>:json}
#           POST   /api/users(.:format)                      api/users#create {:format=>:json}
# api_user  GET    /api/users/:id(.:format)                  api/users#show {:format=>:json}      
#           PATCH  /api/users/:id(.:format)                  api/users#update {:format=>:json}
#           PUT    /api/users/:id(.:format)                  api/users#update {:format=>:json}
#           DELETE /api/users/:id(.:format)                  api/users#destroy {:format=>:json}