Rails.application.routes.draw do
	get "tags/:tag" => "treasures#index", as: :tag

	resources :treasures do
		member do
			patch :heart
		end
	end

  devise_for :users

	root "home#index"
end
