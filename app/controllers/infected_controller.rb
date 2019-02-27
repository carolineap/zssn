class InfectedController < ApplicationController	

	before_action :set_survivor, only: [:create]

	# POST /infected/
  	def create
    	if @survivor.update(infected: @survivor.infected + 1)
      		render json: {'survivor': { 'survivor_id': @survivor.id, 'infected': @survivor.infected }}, status: :ok
    	else
      		render json: @survivor.errors, status: :unprocessable_entity
    	end
  	end

  	def set_survivor
      @survivor = Survivor.find(params.require(:id))
    end

end
