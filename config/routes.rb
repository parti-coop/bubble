Rails.application.routes.draw do
  root 'pages#home'
  get 'step1', to: 'pages#step1'

  post 'bills/:slug/upvote', to: 'bills#upvote', as: :upvote_bill
  post 'party_names/upvote', to: 'party_names#upvote', as: :upvote_party_name
  resources 'comments'
end
