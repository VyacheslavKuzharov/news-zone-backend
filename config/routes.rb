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
end
