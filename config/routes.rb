Rails.application.routes.draw do
  get '/:resource_name', to: 'resources#index', as: 'resources'
  post '/:resource_name', to: 'resources#create'
  get '/:resource_name/:id', to: 'resources#show', as: 'resource'
  patch '/:resource_name/:id', to: 'resources#update'
  put '/:resource_name/:id', to: 'resources#update'
  delete '/:resource_name/:id', to: 'resources#delete'
end
