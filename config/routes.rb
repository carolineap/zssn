Rails.application.routes.draw do
  
  resources :survivors, only: [:index, :update, :show, :create] 

  resources :infected, only: [:create]
  
  resources :trade, only: [:create]
  
  scope "/reports", controller: :reports do
		get 'infected_survivors' 
		get 'non_infected_survivors'
		get 'average_resources'
		get 'points_lost'
 	end

end
