Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects do
      resources :developers

      member do
        get :technologies, to: 'projects#getTechnologyByProject'
      end
  end

  resources :technologies
end
