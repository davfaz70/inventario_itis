Rails.application.routes.draw do
scope '(:locale)' do

  devise_for :profs
  devise_for :admins

  namespace :admin do
    resources :tools
    resources :labs
    resources :categories
    get 'dashboard/index'
    get 'tools/choose/:id(.:format)', :to => 'tools#choose', as: "choose_route"
  end
    resources :tools, only: [:index]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end

end
