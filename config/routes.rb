Rails.application.routes.draw do
  devise_for :users
  get 'youtube/index'
  root to: "youtube#index"
  get 'youtube/search'
  post 'youtube/search'
end
