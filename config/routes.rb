Rails.application.routes.draw do
scope '(:locale)' do

  devise_for :profs
  devise_for :admins

  namespace :admin do
    resources :tools
    resources :labs
    resources :categories
    get 'dashboard/index'
    get 'tools/choose/:id(.:format)', :to => 'tools#choose', as: "choose_tool_route"
    get 'labs/choose/:id(.:format)', :to => 'labs#choose', as: "choose_lab_route"
    get 'labs/assign/:id(.:format)', :to => 'labs#assign', as: "assign_lab_route"
    get 'labs/assign_update/:id/:tool(.:splat)', :to => 'labs#assign_update', as: "assign_update_lab_route"
  end
    resources :tools, only: [:index] do
      resources :tempbooks, only: [:new, :create]
    end
  resources :categories, only: [:show] 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end

end
