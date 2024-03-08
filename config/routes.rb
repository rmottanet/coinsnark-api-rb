# coinsnark-rb/config
Rails.application.routes.draw do
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
	
	# Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
	# Can be used by load balancers and uptime monitors to verify that the app is live.
	get "up" => "rails/health#show", as: :rails_health_check
	
	# Rota raiz para renderizar HTML básico
	root 'main#index'
	
	get 'api/currency', to: 'currency#currency_names'
	
	get 'api/convert', to: 'conversion#convert_currency'
	
	# error
	match '*unmatched_route', to: 'application#not_found', via: :all	
end
