Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :projects, only: [:index, :show, :new, :create] do
    get :new_estimation, on: :member
    put :estimate, on: :member
    get :new_assignment, on: :member
    put :assign_developer, on: :member
    get :new_weekly_hours_assignment, on: :member
    put :assign_working_hours, on: :member
    get :new_deadline, on: :member
    put :assign_deadline, on: :member
  end

  resources :developers, only: [:index, :new, :create]
  resources :orders, only: [:index]
end
