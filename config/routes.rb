Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end
    resources :lists, only: [] do
      resources :items, only: [:create]
    end
    resources :items, only: [:destroy]
  end
end


# Prefix Verb   URI Pattern                                           Controller#Action
# api_users GET    /api/users(.:format)                               api/users#index {:format=>:json}
#           POST   /api/users(.:format)                               api/users#create {:format=>:json}
# api_user  GET    /api/users/:id(.:format)                           api/users#show {:format=>:json}      
#           PATCH  /api/users/:id(.:format)                           api/users#update {:format=>:json}
#           PUT    /api/users/:id(.:format)                           api/users#update {:format=>:json}
#           DELETE /api/users/:id(.:format)                           api/users#destroy {:format=>:json}

# api_user_lists GET    /api/users/:user_id/lists(.:format)           api/lists#index {:format=>:json}
#                POST   /api/users/:user_id/lists(.:format)           api/lists#create {:format=>:json}
# api_user_list  GET    /api/users/:user_id/lists/:id(.:format)       api/lists#show {:format=>:json}
#                PATCH  /api/users/:user_id/lists/:id(.:format)       api/lists#update {:format=>:json}
#                PUT    /api/users/:user_id/lists/:id(.:format)       api/lists#update {:format=>:json}
#                DELETE /api/users/:user_id/lists/:id(.:format)       api/lists#destroy {:format=>:json}

# api_list_items POST   /api/lists/:list_id/items(.:format)           api/items#create {:format=>:json}
# api_item       DELETE /api/items/:id(.:format)                      api/items#destroy {:format=>:json}