Rails.application.routes.draw do
  devise_for :users
  
  resources :notes do
    get 'home', on: :collection
  end

  root "notes#home"
end
