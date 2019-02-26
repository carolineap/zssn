class TradeController < ApplicationController

	@survivor_1
	@survivor_2

	# POST trade
	def create

		if params.has_key?("items") and params[:items].length == 2 and params[:items][0].has_key?("id") and params[:items][1].has_key?("id") 

			get_survivor_1
			get_survivor_2

			if @survivor_1.is_infected? or @survivor_2.is_infected? 
				render status: :forbidden and return
			end

			water_1, food_1, medication_1, ammunition_1 = trade_params(params[:items][0])
			water_2, food_2, medication_2, ammunition_2 = trade_params(params[:items][1])

			if @survivor_1.enough_items?(water_1, food_1, medication_1, ammunition_1) and @survivor_2.enough_items?(water_2, food_2, medication_2, ammunition_2)

				if calculate(water_1, food_1, medication_1, ammunition_1) == calculate(water_2, food_2, medication_2, ammunition_2)

					params_1 = @survivor_1.trade(water_1, food_1, medication_1, ammunition_1, water_2, food_2, medication_2, ammunition_2)
					params_2 = @survivor_2.trade(water_2, food_2, medication_2, ammunition_2, water_1, food_1, medication_1, ammunition_1)

					if @survivor_1.update(params_1) and @survivor_2.update(params_2)
						response = { :survivor_1 => params_1, :survivor_2 => params_2 }
						render :json => response, status: :ok
					else
						response = { :survivor_1 => @survivor_1.errors, :survivor_2 => @survivor_2.errors }
						render json: response, status: :unprocessable_entity
					end

				else
					render status: :unprocessable_entity
				end

			else
				render status: :unprocessable_entity
			end
		else
			render status: :bad_request
		end

	end

	def trade_params(parameter)
		water = food = medication = ammunition = 0
      	parameter.permit(:id, :water, :food, :medication, :ammunition)
      	water = parameter[:water] if parameter[:water]
      	food = parameter[:food] if parameter[:food]
      	medication = parameter[:medication] if parameter[:medication]
      	ammunition = parameter[:ammunition] if parameter[:ammunition]
      	return water.to_i, food.to_i, medication.to_i, ammunition.to_i
	end

    private
    	
    	def get_survivor_1
    		@survivor_1 = Survivor.find(params[:items][0]["id"])
    	end

    	def get_survivor_2
    		@survivor_2 = Survivor.find(params[:items][1]["id"])
    	end


    private
		def calculate(water, food, medication, ammunition)
	    		water*4 + food*3 + medication*2 + ammunition
	    end
end	
