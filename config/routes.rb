Rails.application.routes.draw do
  root to: 'api/v1/posts#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts
    end
  end
end
