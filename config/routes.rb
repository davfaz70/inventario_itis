Rails.application.routes.draw do

  get 'categories/show'

  devise_for :profs, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'profs/omniauth_callbacks'}

scope '(:locale)' do

  devise_for :profs, skip: :omniauth_callbacks, controllers: {
    registrations: 'profs/registrations',
    confirmations: 'profs/confirmations',
   }
  devise_for :admins, controllers: {
    registrations: 'admins/registrations'
  }

  namespace :admin do
    resources :tools do
      resources :documentations, only: [:destroy]
      resources :photos, only: [:destroy]
    end
    resources :labs
    resources :categories
    resources :technicals do
      resources :lab_technicals
    end
    resources :books, only: [:update, :destroy]
    get 'dashboard/index'
    get 'tools/choose/:id(.:format)', :to => 'tools#choose', as: "choose_tool_route"
    get 'labs/assign/:id(.:format)', :to => 'labs#assign', as: "assign_lab_route"
    get 'labs/assign_update/:id/:tool(.:splat)', :to => 'labs#assign_update', as: "assign_update_lab_route"
    post 'authorize/:id(.:format)', :to => 'dashboard#authorize', as: "authorize_route"
  end
    resources :tools, only: [:index, :show] do
      resources :tempbooks, only: [:create]
      resources :posts, only: [:create, :edit, :update, :destroy]
    end
  resources :categories, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :schools
end

end
