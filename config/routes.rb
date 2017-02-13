Rails.application.routes.draw do
  resources :users
  root 'static_pages#home'
  get 'contact' => 'static_pages#contact'
  get 'about' => 'static_pages#about'
  get'login'=> 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients  do
    member do
      get :generate_invoice
      resources :user_patients do
        member do
          get :fetch
        end
      end
    end
  end

  get 'reports' => "reports#reports"
  get 'my_reports' => "reports#my_reports"
  get 'fetchReports' => "reports#fetch_reports"
  get 'fetch_my_reports' => "reports#fetch_my_reports"
  get 'fetchReportsPdf' => "reports#fetch_reports_download"
  get 'searchPatients' => 'patients#searchPatients'
  get 'search' => 'patients#search'
  get 'downloadPdf' => 'patients#downloadPdf'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
