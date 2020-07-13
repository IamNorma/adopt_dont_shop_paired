Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch 'pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy'

  patch '/favorites/:pet_id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'
  delete '/favorites/:pet_id', to: 'favorites#destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get '/applications/new', to: 'applications#new'
  post '/applications/new', to: 'applications#create'
end
