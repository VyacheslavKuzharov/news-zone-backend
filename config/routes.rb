Rails.application.routes.draw do

  namespace :admin do
    root 'welcome#index'
  end
end
