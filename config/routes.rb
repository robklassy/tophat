Rails.application.routes.draw do
  resources :schools, only: [:index, :show]
  resources :faculties, only: [:index, :show]
  resources :courses, only: [:index, :show]
  resources :students, only: [:index, :show]
  resources :professors, only: [:index, :show]

  resources :discussion_questions
  resources :discussion_question_posts do
    member do
      put 'like'
      put 'dislike'
    end
  end

  resources :courses, only: [:index, :show] do
    resources :discussion_questions, only: [:index, :show] do
      resources :discussion_question_posts, only: [:index, :show]
    end
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
