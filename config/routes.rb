Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: "users/registrations" }, path_names: { edit: ":id/edit" }
  devise_scope :user do
    authenticated do
      root :to => "users#index"
    end
    root :to => "devise/sessions#new"
  end
end
