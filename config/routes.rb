Rails.application.routes.draw do
  resources :projects, only: [:index, :show, :create] do
    put :estimate, on: :member
    put :assign_developer, on: :member
  end

  resources :developers, only: [:index, :create]
end
