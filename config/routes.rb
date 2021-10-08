Rails.application.routes.draw do
  get 'rewards/index'
  devise_for :users
  root to: 'questions#index'

  resources :questions, shallow: true do
    resources :answers, shallow: true, except: %i[index new] do
      patch 'set_best', on: :member
    end
  end

  resources :attachments, only: :destroy

  resources :rewards, only: %i[index]

  resources :links, only: %i[destroy]
end
