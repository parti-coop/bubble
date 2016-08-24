Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'pages#home'

  get 'step1', to: 'pages#step1'
  get 'step2', to: 'pages#step2'
  get 'step3', to: 'pages#step3'
  get 'propositions', to: 'propositions#show'
  get 'proposition/:slug', to: 'propositions#show', as: 'proposition'

  get 'quiz', to: 'quizzes#show'
  get 'result_quiz', to: 'quizzes#result'
  get 'report_quiz', to: 'quizzes#report'
  get 'seo_report_quiz', to: 'quizzes#seo_report'

  post 'debates/:slug/choose_alpha', to: 'debates#choose_alpha', as: :choose_alpha_debates
  post 'debates/:slug/choose_beta', to: 'debates#choose_beta', as: :choose_beta_debates
  post 'debates/:slug/choose_hold', to: 'debates#choose_hold', as: :choose_hold_debates
  resources 'opinions', only: [:create, :index]

  post 'bills/:slug/upvote', to: 'bills#upvote', as: :upvote_bill
  post 'party_names/upvote', to: 'party_names#upvote', as: :upvote_party_name
  get 'users/:id/card', to: 'users#card', as: :user_card

  namespace :admin do
    root to: 'base#index'
    get 'download_emails', to: 'base#download_emails'
  end

  resources :comments
  resources :posts do
    member do
      post :upvote
      post :unvote
      post :stick
      post :unstick
    end
  end
end
