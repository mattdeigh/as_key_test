Rails.application.routes.draw do
  post '/direct-uploads', to: 'in_direct_uploads#create'
  post '/documents', to: 'documents#create'
  get '/documents', to: 'documents#index'
end
