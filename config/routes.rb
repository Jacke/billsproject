Billsproject::Application.routes.draw do
  resources :shift_rows

  resources :sites
  resources :shifts
  
  resources :employees
  devise_for :employees
  # The priority is based upon order of creation: first created -> highest priority.

  root 'home#index'

end
