Rails.application.routes.draw do
  post '/assignments', to: 'assignments#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
