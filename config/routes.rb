Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :projects, only: [:index, :show, :create] do
    put :estimate, on: :member
    put :assign_developer, on: :member
    put :assign_working_hours, on: :member
    put :assign_deadline, on: :member
  end

  resources :developers, only: [:index, :new, :create]
end
