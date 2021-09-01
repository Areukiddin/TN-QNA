Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  resources :questions, shallow: true do
    resources :files, shallow: true, only: [] do
      delete 'delete_attachment', to: 'questions#delete_attachment', on: :member
      patch 'add_attachment', to: 'questions#add_attachment', on: :member
    end
    resources :answers, shallow: true, except: %i[index new] do
      patch 'set_best', on: :member
      resources :files, only: [] do
        delete 'delete_answer_attachment', to: 'answers#delete_attachment', on: :member
        patch 'add_answer_attachment', to: 'answers#add_attachment', on: :member
      end
    end
  end
end
