Rails.application.routes.draw do
  get 'youtube/index'
  root to: "youtube#index"
  get 'youtube/search'
  post 'youtube/search'
end
