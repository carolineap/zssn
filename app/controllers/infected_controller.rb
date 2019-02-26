class InfectedController < ApplicationController	

	before_action :set_survivor, only: [:update]

	# PATCH/PUT /infected/1
  	def update
    	if @survivor.update(infected: @survivor.infected + 1)
      		render json: @survivor
    	else
      		render json: @survivor.errors, status: :unprocessable_entity
    	end
  	end

  	def set_survivor
      @survivor = Survivor.find(params[:id])
    end

end
