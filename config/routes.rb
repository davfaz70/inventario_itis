Rails.application.routes.draw do

    devise_for :profs, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'profs/omniauth_callbacks'}
    #devise_for :technicals, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'technicals/omniauth_callbacks'}

    scope '(:locale)' do

      devise_for :profs, skip: :omniauth_callbacks, controllers: {
        registrations: 'profs/registrations',
        confirmations: 'profs/confirmations',
      }

      devise_for :technicals, controllers: {
        registrations: 'technicals/registrations',
        confirmations: 'technicals/confirmations',
        sessions: 'technicals/sessions',
      }

      devise_for :admins, controllers: {
        registrations: 'admins/registrations'
      }

      namespace :technical do
        get 'dashboard/index'
        resources :tools, only: [:index, :show] do
          resources :labs, only: [:index] do
            resources :reportings, only: [:new, :create, :show, :edit, :update, :destroy]
          end
        end
        resources :labs, only: [:show]
        resources :reportings, only: [:index]
        resources :requests
        resources :books, only: [:destroy]
      end

      namespace :admin do
        resources :tools do
          resources :documentations, only: [:destroy]
          resources :photos, only: [:destroy]
          resources :books, only: [:index]
        end
        resources :labs do
          resources :lab_technicals, only: [:new, :create, :edit, :update]
        end
        resources :technicals, only: [:index, :show] do
          resources :lab_technicals, only: [:new, :create, :edit, :update]
        end
        resources :requests, only: [:index, :show, :update, :destroy]
        resources :categories
        resources :lab_technicals, only: [:destroy]
        resources :books, only: [:update, :destroy]
        get 'dashboard/index'
        get 'tools/choose/:id(.:format)', :to => 'tools#choose', as: "choose_tool_route"
        get 'labs/assign/:id(.:format)', :to => 'labs#assign', as: "assign_lab_route"
        post 'labs/assign_update/:id/(.:format)', :to => 'labs#assign_update', as: "assign_update_lab_route"
        post 'authorize/:id(.:format)', :to => 'dashboard#authorize', as: "authorize_route"
        post 'confirm/:id(.:format)', :to => 'dashboard#confirm', as: "confirm_route"
        post 'htmlcreate(.:format)', :to => 'categories#htmlcreate', as: "htmlcreate_route"
        delete 'deleteprof/:id(.:format)', :to => 'dashboard#deleteprof', as: "deleteprof_route"
        post 'reportings/dismiss/:id(.:format)', :to => 'reportings#dismiss', as: "dismiss_route"
        post 'reportings/fix/:id(.:format)', :to => 'reportings#fix', as: "fix_route"
        post 'reportings/replace/:id(.:format)', :to => 'reportings#replace', as: "replace_route"
      end

      post 'avaiable/:tool_id(.:format)', :to => 'tempbooks#avaiable', as: "avaiable_route"
      resources :tools, only: [:index, :show] do
        resources :tempbooks, only: [:new, :create]
        resources :posts, only: [:create, :edit, :update, :destroy]
      end
      resources :categories, only: [:create]
      resources :requests, only: [:new, :create, :index, :show]
      resources :books, only: [:index]

      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
      root to: "home#index"
      #resources :schools
    end
end
