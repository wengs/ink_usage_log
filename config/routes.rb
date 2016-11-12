Rails.application.routes.draw do
  root to: 'homes#index'
  ActiveAdmin.routes(self)
  devise_for :users
  resources :homes, only: [:index]
  resources :ink_usages
  resources :machines do
    resources :machine_part_numbers, only: [:index]
  end
  resources :wastes
  resources :part_numbers_imports, only: [:create]
  resources :dashboards, only: [:index, :new]
  resources :ink_usage_dashboards, only: [:index]
  resources :waste_dashboards, only: [:index]

  get '/ink_usage_dashboards/download_csv' => 'ink_usage_dashboards#download_csv'
  get '/waste_dashboards/download_csv' => 'waste_dashboards#download_csv'
end
