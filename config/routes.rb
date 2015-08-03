Rails.application.routes.draw do
	get "tags/:tag" => "treasures#index", as: :tag

	resources :treasures do
		member do
			patch :heart
		end

		collection do
			get :autocomplete_tags
		end
	end

  devise_for :users

	resources :users, only: [:show]

	root "home#index"
end
