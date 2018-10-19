Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }, path_names: { edit: ":id/edit" }
  devise_scope :user do
    root :to => "users#root"
  end
  resources :users, only: [:index] do
    resources :interviews do
      member do
        patch :approve
      end
    end
  end
end
