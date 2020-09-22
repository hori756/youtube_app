Rails.application.routes.draw do
  get 'youtube/index'
  root to: "youtube#index"
end
