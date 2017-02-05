Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'

  get 'contact' => 'static_pages#contact'
  get 'about' => 'static_pages#about'
  get'login'=> 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
