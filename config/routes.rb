Rails.application.routes.draw do
	get "tags/:tag" => "treasures#index", as: :tag

	resources :treasures do
		member do
			patch :heart
			get :heart
		end

		collection do
			get :autocomplete_tags
			get :recent
			get :popular
		end
	end

  devise_for :users, controllers: { registrations: :registrations }

	resources :users, only: [:show] do
		member { get :hearted }
	end

	root "home#index"
end
