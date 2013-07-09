Billsproject::Application.routes.draw do
  resources :sites

  devise_for :employees
  # The priority is based upon order of creation: first created -> highest priority.

  root 'home#index'

end
