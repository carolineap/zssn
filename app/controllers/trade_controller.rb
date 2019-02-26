class TradeController < ApplicationController

	# POST trade
	def create

		if params.has_key?("items") and params[:items].length == 2 and params[:items][0].has_key?("id") and params[:items][1].has_key?("id") 

			
					
		else
			render status: :unprocessable_entity
		end

	end

	def trade_params(parameter)
		water = food = medication = ammunition = 0
      	parameter.permit(:id, :water, :food, :medication, :ammunition)
      	water = parameter[:water] if parameter[:water]
      	food = parameter[:food] if parameter[:food]
      	medication = parameter[:medication] if parameter[:medication]
      	ammunition = parameter[:ammunition] if parameter[:ammunition]
      	return water, food, medication, ammunition
	end

    private
    	def get_survivor(id)
    		Survivor.find(id)
    	end

    private
		def calculate(water, food, medication, ammunition)
	    		water*4 + food*3 + medication*2 + ammunition
	    end
end	
