Rails.application.routes.draw do
  root 'banks#index'

  get 'create', to: 'banks#create'
  get 'update', to: 'banks#update'
  get 'exchange', to: 'banks#exchange'
end
