Rails.application.routes.draw do

scope '(:locale)' do

get '/change_locale/:locale', to: 'locale#change_locale', as: :change_locale

  devise_for :students, controllers: {
        confirmations: 'students/confirmations',
        omniauth: 'students/omniauth',
        passwords: 'students/passwords',
        registrations: 'students/registrations',
        sessions: 'students/sessions',
        unlocks: 'students/unlocks'
      }

  devise_for :admins

  resources :tools

  get 'tools/choose/:id(.:format)', :to => 'tools#choose', as: "choose_route"

  post 'tools/prenotate/:id(.:format)', :to => 'tools#prenotate', as: "prenotate_route"

  get 'dashboard/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
end

end
