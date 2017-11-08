Rails.application.routes.draw do

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

  namespace :api do
    namespace :v1 do
      resources :news do
        get 'photos', action: 'news_photos', on: :member
      end
    end
  end
end
