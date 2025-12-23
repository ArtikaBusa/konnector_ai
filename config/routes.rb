Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "login", to: "sessions#create"

      resources :schools, only: [:index, :show, :create]
      resources :courses, only: [:index, :create]
      resources :batches, only: [:index, :create] do
        member do
          get :classmates
        end
      end
      resources :enrollments, only: [:index, :create] do
        member do
          patch :approve
          patch :reject
        end
      end
    end
  end

  devise_for :users

  namespace :school_admin do
    # SchoolAdmin can edit ONLY their own school
    resource :school, only: [:edit, :update]

    # Courses owned by school_admin
    resources :courses do
      resources :batches do
        post :add_student, on: :member
      end
    end

    # Enrollment approvals (school-wide)
    resources :enrollments, only: [:index] do
      member do
        patch :approve
        patch :reject
      end
    end
  end


  resources :batches, only: [] do
    get :classmates, on: :member
  end

  namespace :student do
    root "dashboard#index"
    resources :batches, only: [:index, :show] do
      post :enroll, on: :member
    end
  end

  namespace :admin do
    root to: "schools#index"
    get "dashboard", to: "dashboard#index"
    resources :schools
  end

  root "home#index"

  unless Rails.env.development?
    match "*path", to: "application#render_404", via: :all
  end

end
