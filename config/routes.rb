Rails.application.routes.draw do
  post '/projects', to: 'projects#create'
  put '/projects/:uuid/estimate', to: 'projects#estimate'
  get '/projects', to: 'projects#index'
  get '/projects/:uuid', to: 'projects#show'

  get '/developers', to: 'developers#index'
  post '/developers', to: 'developers#create'

  post '/assignments', to: 'assignments#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
