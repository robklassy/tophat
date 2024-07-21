Rails.application.routes.draw do
  # get 'discussion_question_posts/index'
  # get 'discussion_question_posts/new'
  # get 'discussion_question_posts/show'
  # get 'discussion_question_posts/create'
  # get 'discussion_question_posts/edit'
  # get 'discussion_question_posts/update'
  # get 'discussion_question_posts/destroy'
  # get 'discussion_question_posts/like'
  # get 'discussion_question_posts/dislike'
  # get 'discussion_question_posts/index'
  # get 'discussion_question_posts/new'
  # get 'discussion_question_posts/show'
  # get 'discussion_question_posts/create'
  # get 'discussion_question_posts/edit'
  # get 'discussion_question_posts/update'
  # get 'discussion_question_posts/destroy'
  # get 'discussion_questions/index'
  # get 'discussion_questions/new'
  # get 'discussion_questions/show'
  # get 'discussion_questions/create'
  # get 'discussion_questions/edit'
  # get 'discussion_questions/update'
  # get 'discussion_questions/destroy'
  get 'faculties/index'
  get 'faculties/new'
  get 'faculties/show'
  get 'faculties/create'
  get 'faculties/edit'
  get 'faculties/update'
  get 'faculties/destroy'
  get 'students/index'
  get 'students/new'
  get 'students/show'
  get 'students/create'
  get 'students/edit'
  get 'students/update'
  get 'students/destroy'
  # get 'courses/index'
  # get 'courses/new'
  # get 'courses/show'
  # get 'courses/create'
  # get 'courses/edit'
  # get 'courses/update'
  # get 'courses/destroy'
  get 'professors/index'
  get 'professors/new'
  get 'professors/show'
  get 'professors/create'
  get 'professors/edit'
  get 'professors/update'
  get 'professors/destroy'

  resources :courses do
    resources :discussion_questions do
      resources :discussion_question_posts
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
