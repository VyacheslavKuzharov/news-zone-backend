Rails.application.routes.draw do

  apipie
  devise_for :users,
             path: :admin,
             controllers: {
                 registrations: 'users/registrations',
                 sessions:      'users/sessions'
             }


  namespace :admin do
    root 'dashboard#index'
    resources :news
    resources :users
  end

  namespace :api, defaults: { format: 'json' } do
    resources :authentication, only: :create do
      collection do
        post 'authenticate', to: 'authentication#authenticate'
        delete 'logout', to: 'authentication#logout'
      end
    end

    namespace :v1 do
      resources :news
    end
  end
end
