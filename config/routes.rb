Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'

  get 'step1', to: 'pages#step1'
  get 'step2', to: 'pages#home'

  post 'bills/:slug/upvote', to: 'bills#upvote', as: :upvote_bill
  post 'party_names/upvote', to: 'party_names#upvote', as: :upvote_party_name
  get 'users/:id/card', to: 'users#card', as: :user_card
  resources :comments
  resources :posts
end
