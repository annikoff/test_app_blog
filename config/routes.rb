Rails.application.routes.draw do
  root to: 'posts#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts
    end
  end
end
