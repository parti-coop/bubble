Rails.application.routes.draw do
  root 'pages#home'

  post 'bills/:slug/upvote', to: 'bills#upvote', as: :upvote_bill
  resources 'comments'
end
