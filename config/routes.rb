Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index] do
    post 'follow', on: :member
    delete 'unfollow', on: :member
  end
  
  resources :notes do
    get 'home', on: :collection
    post 'like', on: :member
    delete 'unlike', on: :member
  end

  root "notes#home"
end
