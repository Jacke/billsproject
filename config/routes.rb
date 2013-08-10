Billsproject::Application.routes.draw do

  devise_for :employees, :path_prefix => 'my'
  resources :employees 
  resources :personal_areas, only: [:index], :path => :pm
  resources :histories, only: [:index, :update, :edit] 

  resources :shift_rows


  resources :sites
  resources :shifts do
    collection do
      get 'balance'
      match 'balance', to: 'shifts#balance', via: :get
      match 'balance', to: 'shifts#balance_update', via: [:post, :patch]
      match 'deposit', to: 'shifts#deposit', via: :get
      #match 'deposit', to: 'shifts#deposit_update', via: [:post, :patch]
    end
  end
  

  # The priority is based upon order of creation: first created -> highest priority.
  authenticated :employee do
    root to: 'sites#index', as: :authenticated_root
  end
  root :to => redirect('/employees/sign_in')
  
 
end

# == Route Map (Updated 2013-07-29 16:40)
#
#                       Prefix Verb       URI Pattern                        Controller#Action
#         new_employee_session GET        /employees/sign_in(.:format)       devise/sessions#new
#             employee_session POST       /employees/sign_in(.:format)       devise/sessions#create
#     destroy_employee_session DELETE     /employees/sign_out(.:format)      devise/sessions#destroy
#            employee_password POST       /employees/password(.:format)      devise/passwords#create
#        new_employee_password GET        /employees/password/new(.:format)  devise/passwords#new
#       edit_employee_password GET        /employees/password/edit(.:format) devise/passwords#edit
#                              PATCH      /employees/password(.:format)      devise/passwords#update
#                              PUT        /employees/password(.:format)      devise/passwords#update
# cancel_employee_registration GET        /employees/cancel(.:format)        devise/registrations#cancel
#        employee_registration POST       /employees(.:format)               devise/registrations#create
#    new_employee_registration GET        /employees/sign_up(.:format)       devise/registrations#new
#   edit_employee_registration GET        /employees/edit(.:format)          devise/registrations#edit
#                              PATCH      /employees(.:format)               devise/registrations#update
#                              PUT        /employees(.:format)               devise/registrations#update
#                              DELETE     /employees(.:format)               devise/registrations#destroy
#                    employees GET        /employees(.:format)               employees#index
#                              POST       /employees(.:format)               employees#create
#                 new_employee GET        /employees/new(.:format)           employees#new
#                edit_employee GET        /employees/:id/edit(.:format)      employees#edit
#                     employee GET        /employees/:id(.:format)           employees#show
#                              PATCH      /employees/:id(.:format)           employees#update
#                              PUT        /employees/:id(.:format)           employees#update
#                              DELETE     /employees/:id(.:format)           employees#destroy
#                    histories GET        /histories(.:format)               histories#index
#                              POST       /histories(.:format)               histories#create
#                  new_history GET        /histories/new(.:format)           histories#new
#                 edit_history GET        /histories/:id/edit(.:format)      histories#edit
#                      history GET        /histories/:id(.:format)           histories#show
#                              PATCH      /histories/:id(.:format)           histories#update
#                              PUT        /histories/:id(.:format)           histories#update
#                              DELETE     /histories/:id(.:format)           histories#destroy
#                   shift_rows GET        /shift_rows(.:format)              shift_rows#index
#                              POST       /shift_rows(.:format)              shift_rows#create
#                new_shift_row GET        /shift_rows/new(.:format)          shift_rows#new
#               edit_shift_row GET        /shift_rows/:id/edit(.:format)     shift_rows#edit
#                    shift_row GET        /shift_rows/:id(.:format)          shift_rows#show
#                              PATCH      /shift_rows/:id(.:format)          shift_rows#update
#                              PUT        /shift_rows/:id(.:format)          shift_rows#update
#                              DELETE     /shift_rows/:id(.:format)          shift_rows#destroy
#                        sites GET        /sites(.:format)                   sites#index
#                              POST       /sites(.:format)                   sites#create
#                     new_site GET        /sites/new(.:format)               sites#new
#                    edit_site GET        /sites/:id/edit(.:format)          sites#edit
#                         site GET        /sites/:id(.:format)               sites#show
#                              PATCH      /sites/:id(.:format)               sites#update
#                              PUT        /sites/:id(.:format)               sites#update
#                              DELETE     /sites/:id(.:format)               sites#destroy
#               balance_shifts GET        /shifts/balance(.:format)          shifts#balance
#                              GET        /shifts/balance(.:format)          shifts#balance
#                              POST|PATCH /shifts/balance(.:format)          shifts#balance_update
#                       shifts GET        /shifts(.:format)                  shifts#index
#                              POST       /shifts(.:format)                  shifts#create
#                    new_shift GET        /shifts/new(.:format)              shifts#new
#                   edit_shift GET        /shifts/:id/edit(.:format)         shifts#edit
#                        shift GET        /shifts/:id(.:format)              shifts#show
#                              PATCH      /shifts/:id(.:format)              shifts#update
#                              PUT        /shifts/:id(.:format)              shifts#update
#                              DELETE     /shifts/:id(.:format)              shifts#destroy
#                         root GET        /                                  sites#index
#
