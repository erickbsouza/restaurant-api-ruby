Rails.application.routes.draw do
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :restaurants do
    resources :menus, shallow: true do
      resources :menu_items, shallow: true, only: [:index, :show]
    end
  end

  post "/imports", to: "imports#create"

end
