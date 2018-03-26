Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index] do
    get 'follower', on: :collection
    get 'following', on: :collection
    post 'follow', on: :member
    delete 'unfollow', on: :member
  end
  
  resources :notes do
    get 'home', on: :collection
  end

  root "notes#home"
end
