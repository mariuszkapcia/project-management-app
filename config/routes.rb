Rails.application.routes.draw do
  post '/projects', to: 'projects#create'
  put '/projects/:uuid/estimate', to: 'projects#estimate'
  get '/projects', to: 'projects#index'

  post '/assignments', to: 'assignments#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
