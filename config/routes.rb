Rails.application.routes.draw do
	get "tags/:tag" => "treasures#index", as: :tag

	resources :treasures

  devise_for :users

	root "home#index"
end
