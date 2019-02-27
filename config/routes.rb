Rails.application.routes.draw do
  resources :survivors, only: [:index, :update, :show, :create] 

  resources :infected, only: [:create]
  
  resources :trade
  
  scope "/reports", controller: :reports do
		get 'infected_survivors' 
		get 'non_infected_survivors'
		get 'average_resources'
		get 'points_lost'
 	end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
